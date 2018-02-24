package gameCommon.view.prop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PropInfo;
   import ddt.events.LivingEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gameCommon.model.LocalPlayer;
   
   public class SoulPropBar extends FightPropBar
   {
       
      
      protected var _soulCells:Vector.<SoulPropCell>;
      
      private var _propDatas:Array;
      
      private var _back:DisplayObject;
      
      private var _msgShape:DisplayObject;
      
      private var _lockScreen:DisplayObject;
      
      public function SoulPropBar(param1:LocalPlayer){super(null);}
      
      override protected function configUI() : void{}
      
      override protected function addEvent() : void{}
      
      override protected function removeEvent() : void{}
      
      override public function enter() : void{}
      
      private function __psychicChanged(param1:LivingEvent) : void{}
      
      private function __enableChanged(param1:LivingEvent) : void{}
      
      private function showHelpMsg() : void{}
      
      private function updatePropByPsychic() : void{}
      
      override protected function drawCells() : void{}
      
      override protected function __itemClicked(param1:MouseEvent) : void{}
      
      public function setProps() : void{}
      
      public function set props(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
