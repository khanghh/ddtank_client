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
      
      public function JoinCityBattleView(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function __joinHandler(param1:MouseEvent) : void{}
      
      private function _joinBattleHandler(param1:CityBattleEvent) : void{}
      
      private function _closeClick(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      override public function dispose() : void{}
   }
}
