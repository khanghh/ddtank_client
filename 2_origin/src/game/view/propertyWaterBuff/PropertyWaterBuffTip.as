package game.view.propertyWaterBuff
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BuffInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class PropertyWaterBuffTip extends Sprite implements Disposeable, ITip
   {
       
      
      private var _buffInfo:BuffInfo;
      
      private var _bg:Image;
      
      private var _name:FilterFrameText;
      
      private var _explication:FilterFrameText;
      
      private var _timer:FilterFrameText;
      
      public function PropertyWaterBuffTip()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = UICreatShortcut.creatAndAdd("game.view.propertyWaterBuffTip.bg",this);
         _name = UICreatShortcut.creatTextAndAdd("game.view.propertyWaterBuffTip.nameTxt","1级防御药水",this);
         _explication = UICreatShortcut.creatTextAndAdd("game.view.propertyWaterBuffTip.explicationTxt","防御提升70点",this);
         _timer = UICreatShortcut.creatTextAndAdd("game.view.propertyWaterBuffTip.timerTxt","还剩50分钟",this);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_explication);
         _explication = null;
         ObjectUtils.disposeObject(_timer);
         _timer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get tipData() : Object
      {
         return _buffInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
         _buffInfo = param1 as BuffInfo;
         update();
      }
      
      private function update() : void
      {
         var _loc3_:int = _buffInfo.getLeftTimeByUnit(86400000);
         var _loc2_:int = _buffInfo.getLeftTimeByUnit(3600000);
         var _loc1_:int = _buffInfo.getLeftTimeByUnit(60000);
         _name.text = _buffInfo.buffName;
         _explication.text = _buffInfo.buffItemInfo.Description;
         if(_loc3_ > 0)
         {
            _timer.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timer",_loc3_);
         }
         else if(_loc2_ > 0)
         {
            _timer.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerI",_loc2_);
         }
         else if(_loc1_ > 0)
         {
            _timer.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerII",_loc1_);
         }
         else
         {
            _timer.text = LanguageMgr.GetTranslation("game.view.propertyWaterBuff.timerIII");
            _timer.textColor = 16711680;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
