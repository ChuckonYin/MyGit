//
//  APNumberPad.m
//
//  Created by Andrew Podkovyrin on 16/05/14.
//  Copyright (c) 2014 Podkovyrin. All rights reserved.
//

#import "APNumberPad.h"

#import "APNumberButton.h"
#import "APNumberPadDefaultStyle.h"
#import "YZTGlobalDefine.h"

@interface APNumberPad () {
    BOOL _clearButtonLongPressGesture;
    
	struct {
        unsigned int textInputSupportsShouldChangeTextInRange:1;
		unsigned int delegateSupportsTextFieldShouldChangeCharactersInRange:1;
		unsigned int delegateSupportsTextViewShouldChangeTextInRange:1;
	} _delegateFlags;
}

/**
 *  Array of APNumberButton
 */
@property (copy, readwrite, nonatomic) NSArray *numberButtons;

/**
 *  Point function button
 */
@property (strong, readwrite, nonatomic) APNumberButton *pointButton;

/**
 *  hideKeyboard function button
 */
@property (strong, readwrite, nonatomic) APNumberButton *hideKeyboardButton;

/**
 *  Right function button
 */
@property (strong, readwrite, nonatomic) APNumberButton *clearButton;

/**
 *  OK function button
 */
@property (strong, readwrite, nonatomic) APNumberButton *okButton;

/**
 *  APNumberPad delegate
 */
@property (weak, readwrite, nonatomic) id<APNumberPadDelegate> delegate;

/**
 *  Auto-detected text input
 */
@property (weak, readwrite, nonatomic) UIResponder<UITextInput> *textInput;

/**
 *  Last touch on view. For support tap by tap entering text
 */
@property (strong, readwrite, nonatomic) UITouch *lastTouch;

/**
 *  The class to use for styling the number pad
 */
@property (strong, readwrite, nonatomic) Class<APNumberPadStyle> styleClass;

@end


@implementation APNumberPad

+ (instancetype)numberPadWithDelegate:(id<APNumberPadDelegate>)delegate {
    return [self numberPadWithDelegate:delegate numberPadStyleClass:nil];
}

+ (instancetype)numberPadWithDelegate:(id<APNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass{
    return [[self alloc] initWithDelegate:delegate numberPadStyleClass:styleClass];
}

- (instancetype)initWithDelegate:(id<APNumberPadDelegate>)delegate numberPadStyleClass:(Class)styleClass {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.styleClass = styleClass;
        self.frame = [self.styleClass numberPadFrame];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight; // for support rotation
        //self.backgroundColor = [self.styleClass numberPadBackgroundColor];
        self.backgroundColor = YZTColorWithRGB(231, 231, 231);
        
        [self addNotificationsObservers];
        
        self.delegate = delegate;
        
        // Number buttons (0-9)
        //
        NSMutableArray *numberButtons = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            APNumberButton *numberButton = [self numberButton:i WithBackImage:[UIImage imageNamed:@"number"]
                                            WithHighlightedImage:[UIImage imageNamed:@"numberHighlighted"]];
            [self addSubview:numberButton];
            [numberButtons addObject:numberButton];
        }
        
        // pointButton Function button
        //
        self.pointButton = [self functionButton:@"." WithBackImage:[UIImage imageNamed:@"number"]
                         WithHighlightedImage:[UIImage imageNamed:@"numberHighlighted"]];
        //self.pointButton.titleLabel.font = [self.styleClass functionButtonFont];
        //[self.pointButton setTitleColor:[self.styleClass functionButtonTextColor] forState:UIControlStateNormal];
        self.pointButton.titleLabel.font = YZTFont(28);
        [self.pointButton setTitleColor:YZTColorWithRGB(68, 68, 68) forState:UIControlStateNormal];
        [self.pointButton addTarget:self action:@selector(numberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pointButton];
        
        // hideKeyboard Function button
        //
        self.hideKeyboardButton = [self functionButton:@"" WithBackImage:[UIImage imageNamed:@"hideKeyboard"]
                                  WithHighlightedImage:[UIImage imageNamed:@"hideKeyboardHighlighted"]];
        self.hideKeyboardButton.titleLabel.font = [self.styleClass functionButtonFont];
        [self.hideKeyboardButton setTitleColor:[self.styleClass functionButtonTextColor] forState:UIControlStateNormal];
        [self.hideKeyboardButton addTarget:self action:@selector(hideKeyboardAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.hideKeyboardButton];
        [numberButtons addObject:self.hideKeyboardButton];
        
        // Clear button
        //
        self.clearButton = [self functionButton:@"" WithBackImage:[UIImage imageNamed:@"clearButton"]
                         WithHighlightedImage:[UIImage imageNamed:@"clearButtonHighlighted"]];
        [self.clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [numberButtons addObject:self.clearButton];

        // Ok button
        //
        self.okButton = [self functionButton:@"确定" WithBackImage:[UIImage imageNamed:@"okButton"]
                      WithHighlightedImage:[UIImage imageNamed:@"okButtonHighlighted"]];
        //self.okButton.titleLabel.font = [UIFont systemFontOfSize:20];
        self.okButton.titleLabel.font = YZTFont(20);
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.okButton];
        [numberButtons addObject:self.okButton];
        
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                                    initWithTarget:self action:@selector(longPressGestureRecognizerAction:)];
        longPressGestureRecognizer.cancelsTouchesInView = NO;
        [self.clearButton addGestureRecognizer:longPressGestureRecognizer];
        [self addSubview:self.clearButton];
        
        self.numberButtons = numberButtons;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.delegate = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int rows = 4;
    int sections = 3;
    
    CGFloat sep = [self.styleClass separator];
    CGFloat left = 4.f;
    CGFloat top = 4.f;
    
#if defined(__LP64__) && __LP64__
    CGFloat buttonHeight = trunc((CGRectGetHeight(self.bounds) - sep * (rows - 1)-top*2) / rows);
#else
    CGFloat buttonHeight = truncf((CGRectGetHeight(self.bounds) - sep * (rows - 1)-top*2) / rows);
#endif
    
    CGSize buttonSize = CGSizeMake((CGRectGetWidth(self.bounds) - sep * sections -left*2) / (sections+1), buttonHeight);

    // Number buttons (1-9)
    //
    for (int i = 1; i < 11; i++) {
        APNumberButton *numberButton = self.numberButtons[i];
        numberButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
        
        if (i % sections == 0) {
            left = 4.f;
            top += buttonSize.height + sep;
        } else {
            left += buttonSize.width + sep;
        }
    }
    
    for (int i = 11; i < 13; i ++) {
        CGFloat newWidth = buttonSize.width - 1;
        CGFloat newTop = 4.0f;
        
        if (i % rows == 0) {
            newTop += (buttonHeight + sep) * 2;
        }
        
        APNumberButton *numberButton = self.numberButtons[i];
        numberButton.frame = CGRectMake(buttonSize.width * 3 + sep * 4, newTop, newWidth, buttonHeight*2 + sep);
        
        if (i % rows == 0) {
            self.okButton.frame = numberButton.frame;
        } else {
            self.clearButton.frame = numberButton.frame;
        }
    }
    // pointButton Function button
    //
    left = 4.f;
    self.pointButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
    
    // Number buttons (0)
    //
    left += buttonSize.width + sep;
    UIButton *zeroButton = self.numberButtons.firstObject;
    zeroButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
    
    // Clear button
    //
    left += buttonSize.width + sep;
    self.hideKeyboardButton.frame = CGRectMake(left, top, buttonSize.width, buttonSize.height);
}

#pragma mark - Notifications

- (void)addNotificationsObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidBeginEditing:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textDidEndEditing:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:nil];
}

- (void)textDidBeginEditing:(NSNotification *)notification {
    if (![notification.object conformsToProtocol:@protocol(UITextInput)]) {
        return;
    }
    
    UIResponder<UITextInput> *textInput = notification.object;
    
    if (textInput.inputView && self == textInput.inputView) {
        self.textInput = textInput;
        
        _delegateFlags.textInputSupportsShouldChangeTextInRange = NO;
        _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = NO;
        _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = NO;
        
        if ([self.textInput respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)]) {
            _delegateFlags.textInputSupportsShouldChangeTextInRange = YES;
        } else if ([self.textInput isKindOfClass:[UITextField class]]) {
            id<UITextFieldDelegate> delegate = [(UITextField *)self.textInput delegate];
            if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
                _delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange = YES;
            }
        } else if ([self.textInput isKindOfClass:[UITextView class]]) {
            id<UITextViewDelegate> delegate = [(UITextView *)self.textInput delegate];
            if ([delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
                _delegateFlags.delegateSupportsTextViewShouldChangeTextInRange = YES;
            }
        }
    }
}

- (void)textDidEndEditing:(NSNotification *)notification {
    self.textInput = nil;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[UIDevice currentDevice] playInputClick];
    
    // Perform number button action for previous `self.lastTouch`
    //
    if (self.lastTouch) {
        [self performLastTouchAction];
    }

    // `touches` contains only one UITouch (self.multipleTouchEnabled == NO)
    //
    self.lastTouch = [touches anyObject];
    
    // Update highlighted state for number buttons, cancel `touches` for everything but the catched
    //
    CGPoint location = [self.lastTouch locationInView:self];
    for (APNumberButton *b in self.numberButtons) {
        if (CGRectContainsPoint(b.frame, location)) {
            b.highlighted = YES;
        } else {
            b.highlighted = NO;
            [b np_touchesCancelled:touches withEvent:event];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.lastTouch || ![touches containsObject:self.lastTouch]) {
        return; // ignore old touches movings
    }
    
    CGPoint location = [self.lastTouch locationInView:self];
    
    // Forget highlighted state for functional buttons after move
    //
    if (!CGRectContainsPoint(self.clearButton.frame, location)) {
        [self.clearButton np_touchesCancelled:touches withEvent:event];
        
        // Disable long gesture action for clear button
        //
        _clearButtonLongPressGesture = NO;
    }
    
    if (!CGRectContainsPoint(self.pointButton.frame, location)) {
        [self.pointButton np_touchesCancelled:touches withEvent:event];
    }
    
    if (!CGRectContainsPoint(self.hideKeyboardButton.frame, location)) {
        [self.hideKeyboardButton np_touchesCancelled:touches withEvent:event];
    }
    
    if (!CGRectContainsPoint(self.okButton.frame, location)) {
        [self.okButton np_touchesCancelled:touches withEvent:event];
    }
    
    // Update highlighted state for number buttons
    //
    for (APNumberButton *b in self.numberButtons) {
        b.highlighted = CGRectContainsPoint(b.frame, location);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.lastTouch || ![touches containsObject:self.lastTouch]) {
        return; // ignore old touches
    }
    
    [self performLastTouchAction];
    
    self.lastTouch = nil;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Reset hightlighted state for all buttons, forget `self.lastTouch`
    //
    self.pointButton.highlighted = NO;
    self.hideKeyboardButton.highlighted = NO;
    self.okButton.highlighted = NO;
    self.clearButton.highlighted = NO;
    
    for (APNumberButton *b in self.numberButtons) {
        b.highlighted = NO;
    }
    
    self.lastTouch = nil;
}

- (void)performLastTouchAction {
    // Reset highlighted state for all buttons, perform action for catched button
    //
    CGPoint location = [self.lastTouch locationInView:self];
    for (APNumberButton *b in self.numberButtons) {
        b.highlighted = NO;
        if (CGRectContainsPoint(b.frame, location)) {
            [self numberButtonAction:b];
        }
    }
}

#pragma mark - Custom accessors

- (void)setStyleClass:(Class)styleClass {
    if (styleClass) {
        _styleClass = styleClass;
    } else {
        _styleClass = [APNumberPadDefaultStyle class];
    }
}

#pragma mark - Actions

- (void)numberButtonAction:(UIButton *)sender {
    if(sender == self.clearButton || sender == self.okButton || sender == self.hideKeyboardButton)
    {
        return;
    }
    
    if (!self.textInput) {
        return;
    }
    
    NSString *text = sender.currentTitle;
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        if ([self.textInput shouldChangeTextInRange:self.textInput.selectedTextRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    } else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:text]) {
            [self.textInput insertText:text];
        }
    } else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:text]) {
            [self.textInput insertText:text];
        }
    } else {
        [self.textInput insertText:text];
    }
}

- (void)clearButtonAction {
    if (!self.textInput) {
        return;
    }
    
    if (_delegateFlags.textInputSupportsShouldChangeTextInRange) {
        UITextRange *textRange = self.textInput.selectedTextRange;
        if ([textRange.start isEqual:textRange.end]) {
            UITextPosition *newStart = [self.textInput positionFromPosition:textRange.start inDirection:UITextLayoutDirectionLeft offset:1];
            textRange = [self.textInput textRangeFromPosition:newStart toPosition:textRange.end];
        }
        if ([self.textInput shouldChangeTextInRange:textRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    } else if (_delegateFlags.delegateSupportsTextFieldShouldChangeCharactersInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 1;
        }
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate textField:textField shouldChangeCharactersInRange:selectedRange replacementString:@""]) {
            [self.textInput deleteBackward];
        }
    } else if (_delegateFlags.delegateSupportsTextViewShouldChangeTextInRange) {
        NSRange selectedRange = [[self class] selectedRange:self.textInput];
        if (selectedRange.length == 0 && selectedRange.location > 0) {
            selectedRange.location--;
            selectedRange.length = 1;
        }
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate textView:textView shouldChangeTextInRange:selectedRange replacementText:@""]) {
            [self.textInput deleteBackward];
        }
    } else {
        [self.textInput deleteBackward];
    }
}

- (void)functionButtonAction:(id)sender {
    if (!self.textInput) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(numberPad:functionButtonAction:textInput:)]) {
        [self.delegate numberPad:self functionButtonAction:sender textInput:self.textInput];
    }
}

- (void)hideKeyboardAction:(id)sender {
    
    [self.textInput resignFirstResponder];
}

- (void)okButtonAction:(id)sender {
    if(!self.textInput)
    {
        return;
    }
    if([self.delegate respondsToSelector:@selector(numberPad:oKButtonAction:textInput:)]){
        if ([self.delegate numberPad:self oKButtonAction:sender textInput:self.textInput]) {
            [self.textInput resignFirstResponder];
        }
    }else{
        [self.textInput resignFirstResponder];
    }
}

#pragma mark - Clear button long press

- (void)longPressGestureRecognizerAction:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        _clearButtonLongPressGesture = YES;
        [self clearButtonActionLongPress];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        _clearButtonLongPressGesture = NO;
    }
}

- (void)clearButtonActionLongPress {
    if (_clearButtonLongPressGesture) {
        if ([self.textInput hasText]) {
            [[UIDevice currentDevice] playInputClick];
            
            [self clearButtonAction];
            [self performSelector:@selector(clearButtonActionLongPress) withObject:nil afterDelay:0.1f]; // delay like in iOS keyboard
        } else {
            _clearButtonLongPressGesture = NO;
        }
    }
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

#pragma mark - Additions

+ (NSRange)selectedRange:(id<UITextInput>)textInput {
    UITextRange *textRange = [textInput selectedTextRange];
    
    NSInteger startOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.start];
    NSInteger endOffset = [textInput offsetFromPosition:textInput.beginningOfDocument toPosition:textRange.end];
    
    return NSMakeRange(startOffset, endOffset - startOffset);
}

#pragma mark - Button fabric
- (APNumberButton *)numberButton:(int)number {
    APNumberButton *b = [APNumberButton buttonWithBackgroundColor:[self.styleClass numberButtonBackgroundColor]
                                                 highlightedColor:[self.styleClass numberButtonHighlightedColor]];
    [b setTitleColor:[self.styleClass numberButtonTextColor] forState:UIControlStateNormal];
    b.titleLabel.font = [self.styleClass numberButtonFont];
    [b setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    return b;
}

#pragma mark - Button fabric
- (APNumberButton *)numberButton:(int)number WithBackImage:(UIImage *)backImage WithHighlightedImage:(UIImage *)highlightedImage {
    APNumberButton *b = [APNumberButton buttonWithBackgroundImage:backImage
                                                 highlightedImage:highlightedImage];
    //[b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitleColor:YZTColorWithRGB(68, 68, 68) forState:UIControlStateNormal];
    //b.titleLabel.font = [self.styleClass numberButtonFont];
    b.titleLabel.font = YZTFont(28);
    [b setTitle:[NSString stringWithFormat:@"%d", number] forState:UIControlStateNormal];
    return b;
}

- (APNumberButton *)functionButton {
    //APNumberButton *b = [APNumberButton buttonWithBackgroundColor:[self.styleClass functionButtonBackgroundColor]
    //                                             highlightedColor:[self.styleClass functionButtonHighlightedColor]];
    APNumberButton *b = [APNumberButton buttonWithBackgroundImage:[UIImage imageNamed:@"number"]
                                                 highlightedImage:[UIImage imageNamed:@"numberHighlighted"]];
    b.exclusiveTouch = YES;
    return b;
}

- (APNumberButton *)functionButton:(NSString *)title WithBackImage:(UIImage *)backImage WithHighlightedImage:(UIImage *)highlightedImage {
    APNumberButton *b = [APNumberButton buttonWithBackgroundImage:backImage
                                                 highlightedImage:highlightedImage];
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    b.titleLabel.font = [self.styleClass numberButtonFont];
    [b setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
    b.exclusiveTouch = YES;
    return b;
}

@end
