package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class JoinCityBattleView extends Frame
   {
       
      
      private var _enterBg:Bitmap;
      
      private var _joinBlueBtn:BaseButton;
      
      private var _joinRedBtn:BaseButton;
      
      private var _randomBtn:BaseButton;
      
      private var _joinInfoTxt:FilterFrameText;
      
      private var _closeBnt:BaseButton;
      
      public function JoinCityBattleView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _enterBg = ComponentFactory.Instance.creatBitmap("asset.cityBattle.bg");
         addToContent(_enterBg);
         _closeBnt = ComponentFactory.Instance.creatComponentByStylename("joinCity.closeBtn");
         addToContent(_closeBnt);
         _joinBlueBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.joinBlueBtn");
         _joinRedBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.joinRedBtn");
         addToContent(_joinBlueBtn);
         addToContent(_joinRedBtn);
         _randomBtn = ComponentFactory.Instance.creatComponentByStylename("cityBattle.randomBtn");
         addToContent(_randomBtn);
         _joinInfoTxt = ComponentFactory.Instance.creatComponentByStylename("joinView.info.txt");
         addToContent(_joinInfoTxt);
         _joinInfoTxt.text = LanguageMgr.GetTranslation("ddt.cityBattle.joinView.info");
      }
      
      private function initEvent() : void
      {
         _joinBlueBtn.addEventListener("click",__joinHandler);
         _joinRedBtn.addEventListener("click",__joinHandler);
         _randomBtn.addEventListener("click",__joinHandler);
         CityBattleManager.instance.addEventListener("joinBattle",_joinBattleHandler);
         _closeBnt.addEventListener("click",_closeClick);
      }
      
      private function __joinHandler(e:MouseEvent) : void
      {
         var _loc2_:* = e.currentTarget;
         if(_joinBlueBtn !== _loc2_)
         {
            if(_joinRedBtn !== _loc2_)
            {
               if(_randomBtn === _loc2_)
               {
                  SocketManager.Instance.out.cityBattleJoin(0);
               }
            }
            else
            {
               SocketManager.Instance.out.cityBattleJoin(2);
            }
         }
         else
         {
            SocketManager.Instance.out.cityBattleJoin(1);
         }
      }
      
      private function _joinBattleHandler(e:CityBattleEvent) : void
      {
         dispose();
         CityBattleManager.instance._mainFrame = ComponentFactory.Instance.creatComponentByStylename("cityBattle.mainFrame");
         LayerManager.Instance.addToLayer(CityBattleManager.instance._mainFrame,3,true,1);
      }
      
      private function _closeClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function removeEvent() : void
      {
         _joinBlueBtn.removeEventListener("click",__joinHandler);
         _joinRedBtn.removeEventListener("click",__joinHandler);
         _randomBtn.removeEventListener("click",__joinHandler);
         CityBattleManager.instance.removeEventListener("joinBattle",_joinBattleHandler);
         _closeBnt.removeEventListener("click",_closeClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         var focusDisplay:DisplayObject = StageReferance.stage.focus as DisplayObject;
         if(focusDisplay && contains(focusDisplay))
         {
            StageReferance.stage.focus = null;
         }
         ObjectUtils.disposeObject(_enterBg);
         _enterBg = null;
         ObjectUtils.disposeObject(_closeBnt);
         _closeBnt = null;
         ObjectUtils.disposeObject(_joinBlueBtn);
         _joinBlueBtn = null;
         ObjectUtils.disposeObject(_joinRedBtn);
         _joinRedBtn = null;
         ObjectUtils.disposeObject(_randomBtn);
         _randomBtn = null;
         ObjectUtils.disposeObject(_joinInfoTxt);
         _joinInfoTxt = null;
         super.dispose();
      }
   }
}
