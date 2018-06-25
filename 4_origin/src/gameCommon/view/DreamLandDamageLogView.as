package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class DreamLandDamageLogView extends DreamLandLogBaseView
   {
       
      
      private var _damageBtn:TextButton;
      
      private var _bg:Bitmap;
      
      private var _openFlag:Boolean = false;
      
      public function DreamLandDamageLogView()
      {
         super();
         initEvent();
      }
      
      override protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.game.damageView.bg");
         _infoSprite.addChild(_bg);
         super.initView();
         _titleTxt.text = LanguageMgr.GetTranslation("ddt.game.view.damageView.listText");
         _damageBtn = ComponentFactory.Instance.creatComponentByStylename("game.view.combatGains.recordBtn");
         _damageBtn.text = LanguageMgr.GetTranslation("ddt.game.dreamLand.hurtRecord.btnName");
         addChild(_damageBtn);
      }
      
      private function initEvent() : void
      {
         _damageBtn.addEventListener("click",__onMouseClick);
      }
      
      private function removeEvent() : void
      {
         _damageBtn.removeEventListener("click",__onMouseClick);
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         if(_openFlag)
         {
            TweenLite.to(_infoSprite,0.3,{
               "x":0,
               "scaleX":1,
               "scaleY":1,
               "alpha":1
            });
         }
         else
         {
            TweenLite.to(_infoSprite,0.5,{
               "x":_damageBtn.x + _damageBtn.width / 2,
               "scaleX":0,
               "scaleY":0,
               "alpha":0
            });
         }
         _openFlag = !_openFlag;
      }
      
      override public function updateView(hurts:Array) : void
      {
         var obj:* = null;
         var i:int = 0;
         super.updateView(hurts);
         var len:int = hurts.length > 4?4:hurts.length;
         for(i = 0; i < len; )
         {
            obj = hurts[i];
            _nameVec[i].text = obj.name;
            _valueVec[i].text = obj.hurt;
            i++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_damageBtn);
         _damageBtn = null;
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         super.dispose();
      }
   }
}
