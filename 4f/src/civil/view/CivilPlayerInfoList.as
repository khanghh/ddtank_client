package civil.view
{
   import civil.CivilEvent;
   import civil.CivilModel;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.CivilPlayerInfo;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CivilPlayerInfoList extends Sprite implements Disposeable
   {
      
      private static const MAXITEM:int = 9;
       
      
      private var _currentItem:CivilPlayerItemFrame;
      
      private var _items:Vector.<CivilPlayerItemFrame>;
      
      private var _infoItems:Array;
      
      private var _list:VBox;
      
      private var _model:CivilModel;
      
      private var _selectedItem:CivilPlayerItemFrame;
      
      public function CivilPlayerInfoList(){super();}
      
      private function init() : void{}
      
      public function MemberList(param1:Array) : void{}
      
      public function clearList() : void{}
      
      public function upItem(param1:CivilPlayerInfo) : void{}
      
      private function addEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __civilListHandle(param1:CivilEvent) : void{}
      
      private function __onItemClick(param1:MouseEvent) : void{}
      
      public function get selectedItem() : CivilPlayerItemFrame{return null;}
      
      public function set selectedItem(param1:CivilPlayerItemFrame) : void{}
      
      public function get model() : CivilModel{return null;}
      
      public function set model(param1:CivilModel) : void{}
      
      public function dispose() : void{}
   }
}
