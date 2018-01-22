package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import road7th.utils.StringHelper;
   
   public class KingBlessTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _title:FilterFrameText;
      
      protected var _contentTxt:FilterFrameText;
      
      protected var _notOpenContentTxt:FilterFrameText;
      
      protected var _bottomTxt:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      private var isOpen:Boolean = false;
      
      private var isSelf:Boolean;
      
      public function KingBlessTip()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("hall.kingBlessTips.title");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("hall.kingBlessTips.commonText");
         _notOpenContentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         _bottomTxt = ComponentFactory.Instance.creatComponentByStylename("hall.kingBlessTips.bottomText");
         addChild(_bg);
         addChild(_title);
         addChild(_contentTxt);
         addChild(_notOpenContentTxt);
         addChild(_bottomTxt);
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(param1:Object) : void
      {
         if(param1)
         {
            _data = param1;
            if(_data.hasOwnProperty("isOpen"))
            {
               isOpen = _data["isOpen"];
            }
            if(_data.hasOwnProperty("isSelf"))
            {
               isSelf = _data["isSelf"];
            }
            if(isOpen && isSelf)
            {
               var _loc2_:* = true;
               _contentTxt.visible = _loc2_;
               _loc2_ = _loc2_;
               _title.visible = _loc2_;
               _bottomTxt.visible = _loc2_;
               _notOpenContentTxt.visible = false;
               _title.text = _data["title"];
               _contentTxt.text = StringHelper.trim(String(_data["content"]));
               _bottomTxt.text = _data["bottom"];
            }
            else
            {
               _loc2_ = false;
               _contentTxt.visible = _loc2_;
               _loc2_ = _loc2_;
               _title.visible = _loc2_;
               _bottomTxt.visible = _loc2_;
               _notOpenContentTxt.visible = true;
               _notOpenContentTxt.text = StringHelper.trim(String(_data["content"]));
            }
            updateTransform();
         }
      }
      
      protected function updateTransform() : void
      {
         if(isOpen && isSelf)
         {
            _contentTxt.x = _bg.x + 8;
            _contentTxt.y = 4 + _title.height;
            _bg.width = _contentTxt.width + 20;
            _bg.height = _contentTxt.y + _contentTxt.textHeight + _bottomTxt.height + 10;
            _bottomTxt.x = _contentTxt.x;
            _bottomTxt.y = _contentTxt.y + _contentTxt.textHeight + 4;
         }
         else
         {
            _bg.width = _notOpenContentTxt.width + 16;
            _bg.height = _notOpenContentTxt.height + 8;
            _notOpenContentTxt.x = _bg.x + 8;
            _notOpenContentTxt.y = _bg.y + 4;
         }
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(param1:int) : void
      {
         if(_tipWidth != param1)
         {
            _tipWidth = param1;
            updateTransform();
         }
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_notOpenContentTxt)
         {
            ObjectUtils.disposeObject(_notOpenContentTxt);
         }
         _notOpenContentTxt = null;
         if(_bottomTxt)
         {
            ObjectUtils.disposeObject(_bottomTxt);
         }
         _bottomTxt = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
