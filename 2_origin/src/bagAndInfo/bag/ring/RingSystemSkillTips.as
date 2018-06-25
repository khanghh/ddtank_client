package bagAndInfo.bag.ring
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class RingSystemSkillTips extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      protected var _bg:ScaleBitmapImage;
      
      protected var _name:FilterFrameText;
      
      protected var _contentTxt:FilterFrameText;
      
      private var _line:Image;
      
      private var _nextLevel:FilterFrameText;
      
      private var _limitLevel:FilterFrameText;
      
      protected var _data:Object;
      
      protected var _tipWidth:int;
      
      protected var _tipHeight:int;
      
      public function RingSystemSkillTips()
      {
         super();
         init();
      }
      
      protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         addChild(_bg);
         _bg.width = 230;
         _bg.height = 140;
         _name = ComponentFactory.Instance.creatComponentByStylename("ringSystem.skill.nameText");
         addChild(_name);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("ringSystem.skill.contentText");
         addChild(_contentTxt);
         _line = ComponentFactory.Instance.creatComponentByStylename("HRuleAsset");
         PositionUtils.setPos(_line,"ringSystem.skill.linePos");
         addChild(_line);
         _nextLevel = ComponentFactory.Instance.creatComponentByStylename("ringSystem.skill.nextContentText");
         addChild(_nextLevel);
         _limitLevel = ComponentFactory.Instance.creatComponentByStylename("ringSystem.skill.limitLevel");
         addChild(_limitLevel);
      }
      
      public function set tipData(data:Object) : void
      {
         if(data != null)
         {
            _name.text = data.name;
            _contentTxt.text = data.content;
            _nextLevel.text = data.nextLevel;
            _limitLevel.text = data.limitLevel;
         }
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
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
         ObjectUtils.disposeAllChildren(this);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_contentTxt)
         {
            ObjectUtils.disposeObject(_contentTxt);
         }
         _contentTxt = null;
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
         }
         _line = null;
         if(_nextLevel)
         {
            ObjectUtils.disposeObject(_nextLevel);
         }
         _nextLevel = null;
         if(_limitLevel)
         {
            ObjectUtils.disposeObject(_limitLevel);
         }
         _limitLevel = null;
         _data = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
