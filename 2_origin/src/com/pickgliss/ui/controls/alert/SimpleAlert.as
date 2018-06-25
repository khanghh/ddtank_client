package com.pickgliss.ui.controls.alert
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class SimpleAlert extends BaseAlerFrame
   {
      
      public static const P_frameInnerRect:String = "frameInnerRect";
      
      public static const P_frameMiniH:String = "frameMiniH";
      
      public static const P_frameMiniW:String = "frameMiniW";
      
      public static const P_textField:String = "textFieldStyle";
       
      
      protected var _frameMiniH:int = -2147483648;
      
      protected var _frameMiniW:int = -2147483648;
      
      protected var _textField:TextField;
      
      protected var _textFieldStyle:String;
      
      private var _frameInnerRect:InnerRectangle;
      
      private var _frameInnerRectString:String;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _back:MovieClip;
      
      protected var _seleContent:Sprite;
      
      public function SimpleAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         if(_selectedBandBtn)
         {
            _selectedBandBtn.removeEventListener("click",selectedBandHander);
            ObjectUtils.disposeObject(_selectedBandBtn);
         }
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",selectedHander);
            ObjectUtils.disposeObject(_selectedBtn);
         }
         _selectedBandBtn = null;
         _selectedBtn = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         _frameInnerRect = null;
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
      }
      
      override public function set info(value:AlertInfo) : void
      {
         .super.info = value;
         onPropertiesChanged("info");
         _seleContent = new Sprite();
         if(info.type == 0)
         {
            return;
         }
         addToContent(_seleContent);
         _back = ComponentFactory.Instance.creat("asset.core.stranDown2");
         _back.x = 5;
         _back.y = 46;
         _back.width = this.width;
         _seleContent.addChild(_back);
         _isBand = true;
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("simpleAlertFrame.moneySelectBtn");
         _selectedBandBtn.text = "Xu khóa";
         _selectedBandBtn.x = 155;
         _selectedBandBtn.y = 49;
         _selectedBandBtn.selected = true;
         _selectedBandBtn.enable = false;
         _seleContent.addChild(_selectedBandBtn);
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("simpleAlertFrame.moneySelectBtn");
         _selectedBtn.text = "Xu";
         _selectedBtn.x = 63;
         _selectedBtn.y = 49;
         _seleContent.addChild(_selectedBtn);
         _selectedBtn.addEventListener("click",selectedHander);
         _selectedBtn.x = _back.width / 2 - 62 - _back.width / 15;
         _selectedBandBtn.x = _back.width / 2 + _back.width / 15;
         _seleContent.x = this.width / 2 - _seleContent.width / 2 - _seleContent.parent.x;
         if(_info.selectBtnY != 0)
         {
            _seleContent.y = _info.selectBtnY;
         }
         else
         {
            _seleContent.y = _textField.height + _textField.y - 95;
         }
      }
      
      override protected function creatTheLog() : void
      {
         if(_selectedCheckBtn)
         {
            _selectedCheckBtn.visible = _isShowTheLog;
         }
         else
         {
            layoutFrameRect();
            _changedPropeties["width"] = true;
            _changedPropeties["height"] = true;
            super.onProppertiesUpdate();
            _selectedCheckBtn = ComponentFactory.Instance.creatComponentByStylename("ddt.simpleAlert.selectedCheckButton");
            _selectedCheckBtn.text = info.logText;
            _selectedCheckBtn.x = (this.width - _selectedCheckBtn.width) / 2 - 60;
            _selectedCheckBtn.y = this.height - 77;
            addChild(_selectedCheckBtn);
         }
      }
      
      protected function selectedBandHander(event:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBandBtn.enable = false;
            _selectedBtn.enable = true;
            _selectedBtn.selected = false;
         }
         else
         {
            _isBand = false;
         }
      }
      
      protected function selectedHander(event:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBtn.enable = false;
            _selectedBandBtn.enable = true;
            _selectedBandBtn.selected = false;
         }
         else
         {
            _isBand = true;
         }
      }
      
      public function set frameInnerRectString(value:String) : void
      {
         if(_frameInnerRectString == value)
         {
            return;
         }
         _frameInnerRectString = value;
         _frameInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_frameInnerRectString));
         onPropertiesChanged("frameInnerRect");
      }
      
      public function set frameMiniH(value:int) : void
      {
         if(_frameMiniH == value)
         {
            return;
         }
         _frameMiniH = value;
         onPropertiesChanged("frameMiniH");
      }
      
      public function set frameMiniW(value:int) : void
      {
         if(_frameMiniW == value)
         {
            return;
         }
         _frameMiniW = value;
         onPropertiesChanged("frameMiniW");
      }
      
      public function set textStyle(value:String) : void
      {
         if(_textFieldStyle == value)
         {
            return;
         }
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textFieldStyle = value;
         _textField = ComponentFactory.Instance.creat(_textFieldStyle);
         onPropertiesChanged("textFieldStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      protected function layoutFrameRect() : void
      {
         var height:int = !!_seleContent?_textField.height + _seleContent.height:Number(_textField.height);
         var rectangle:Rectangle = _frameInnerRect.getInnerRect(_textField.width,height);
         if(rectangle.width > _frameMiniW)
         {
            _textField.x = _frameInnerRect.para1;
            _width = rectangle.width;
         }
         else
         {
            _textField.x = _frameInnerRect.para1 + (_frameMiniW - rectangle.width) / 2;
            _width = _frameMiniW;
         }
         if(rectangle.height > _frameMiniH)
         {
            _textField.y = _frameInnerRect.para3;
            _height = rectangle.height;
         }
         else
         {
            _textField.y = _frameInnerRect.para3 + (_frameMiniH - rectangle.height) / 2;
            _height = _frameMiniH;
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["info"])
         {
            updateMsg();
            if(_frameInnerRect)
            {
               layoutFrameRect();
               _changedPropeties["width"] = true;
               _changedPropeties["height"] = true;
            }
         }
         super.onProppertiesUpdate();
      }
      
      protected function updateMsg() : void
      {
         _textField.autoSize = "left";
         if(_info.mutiline)
         {
            _textField.multiline = true;
            if(!info.enableHtml)
            {
               _textField.wordWrap = true;
            }
            if(_info.textShowWidth > 0)
            {
               _textField.width = _info.textShowWidth;
            }
            else
            {
               _textField.width = DisplayUtils.getTextFieldMaxLineWidth(String(_info.data),_textField.defaultTextFormat,info.enableHtml);
            }
         }
         if(_info.enableHtml)
         {
            _textField.htmlText = String(_info.data);
         }
         else
         {
            _textField.text = String(_info.data);
         }
      }
   }
}
