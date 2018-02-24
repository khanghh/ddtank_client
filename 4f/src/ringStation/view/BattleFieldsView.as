package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.geom.Point;
   import ringStation.model.BattleFieldListItemInfo;
   import road7th.comm.PackageIn;
   
   public class BattleFieldsView extends Frame
   {
      
      private static const BATTLEFILEDSNUM:int = 11;
       
      
      private var _bg:MutipleImage;
      
      private var _itemVec:Vector.<BattleFieldsItem>;
      
      public function BattleFieldsView(){super();}
      
      private function initView() : void{}
      
      private function initItemData() : void{}
      
      private function sendPkg() : void{}
      
      private function initEvent() : void{}
      
      protected function __onUpdateNewBattleField(param1:PkgEvent) : void{}
      
      public function show() : void{}
      
      private function removeEvent() : void{}
      
      private function __frameEventHandler(param1:FrameEvent) : void{}
      
      override public function dispose() : void{}
   }
}
