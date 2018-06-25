package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITransformableTipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortionSkillInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class ConsortionSkillCell extends Sprite implements Disposeable, ITransformableTipedDisplay
   {
       
      
      private var _info:ConsortionSkillInfo;
      
      private var _bg:Bitmap;
      
      public function ConsortionSkillCell()
      {
         super();
         buttonMode = true;
         ShowTipManager.Instance.addTip(this);
      }
      
      public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         if(_info.isOpen)
         {
            return LanguageMgr.GetTranslation("civil.register.NicknameLabel") + _info.name + "\n" + LanguageMgr.GetTranslation("ddt.view.skillFrame.effect") + _info.descript.replace("{0}",_info.value) + "\n" + LanguageMgr.GetTranslation("ddt.consortion.skillTip.validity",_info.validity);
         }
         return LanguageMgr.GetTranslation("civil.register.NicknameLabel") + _info.name + "\n" + LanguageMgr.GetTranslation("ddt.view.skillFrame.effect") + _info.descript.replace("{0}",_info.value);
      }
      
      public function get info() : ConsortionSkillInfo
      {
         return _info;
      }
      
      public function set tipData(value:Object) : void
      {
         _info = value as ConsortionSkillInfo;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortion.skillIcon." + _info.pic);
         PositionUtils.setPos(_bg,"asset.consortion.skillIcon.pos");
         addChild(_bg);
         _bg.smoothing = true;
         if(!_info.isOpen)
         {
            this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         }
         else
         {
            this.filters = null;
         }
      }
      
      public function contentRect(width:int, height:int) : void
      {
         _bg.width = width;
         _bg.height = height;
      }
      
      public function setGray(value:Boolean) : void
      {
         if(!value)
         {
            this.filters = null;
         }
      }
      
      public function get tipDirctions() : String
      {
         return "0";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return 0;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 0;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "ddt.view.tips.MultipleLineTip";
      }
      
      public function set tipStyle(value:String) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get tipWidth() : int
      {
         return 200;
      }
      
      public function set tipWidth(w:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return -1;
      }
      
      public function set tipHeight(h:int) : void
      {
      }
   }
}
