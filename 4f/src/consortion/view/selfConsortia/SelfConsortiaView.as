package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SelfConsortiaView extends Sprite implements Disposeable
   {
       
      
      private var _BG:MovieImage;
      
      private var _infoView:ConsortionInfoView;
      
      private var _memberList:MemberList;
      
      private var _placardAndEvent:PlacardAndEvent;
      
      private var _buildingManager:BuildingManager;
      
      private var _DissolveConsortia:TextButton;
      
      public function SelfConsortiaView(){super();}
      
      public function enterSelfConsortion() : void{}
      
      private function init() : void{}
      
      private function initEvent() : void{}
      
      private function __dissolve(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
