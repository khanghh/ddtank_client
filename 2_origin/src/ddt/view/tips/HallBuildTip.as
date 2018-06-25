package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class HallBuildTip extends Sprite implements ITransformableTip
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _contentTxt:FilterFrameText;
      
      protected var _title:FilterFrameText;
      
      private var _rule:ScaleBitmapImage;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function HallBuildTip()
      {
         super();
         visible = false;
         init();
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("hall.tips.title");
         _rule = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("core.commonTipText");
         addChild(_bg);
         addChild(_title);
         addChild(_rule);
         addChild(_contentTxt);
         PositionUtils.setPos(_rule,"hall.tip.rule.pos");
         PositionUtils.setPos(_contentTxt,"hall.tip.context.pos");
      }
      
      public function get tipData() : Object
      {
         return _data;
      }
      
      public function set tipData(data:Object) : void
      {
         if(data != null)
         {
            _data = data;
            _title.text = _data["title"];
            _contentTxt.text = _data["content"];
            update();
         }
      }
      
      private function update() : void
      {
         _bg.width = _contentTxt.textWidth + 20;
         _bg.height = _contentTxt.y + _contentTxt.textHeight + 10;
         _rule.width = _bg.width - 10;
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         _tipWidth = w;
      }
      
      public function get tipHeight() : int
      {
         return _bg.height;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
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
         if(_rule)
         {
            ObjectUtils.disposeObject(_rule);
         }
         _rule = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
