package wishingTree.components
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WishingTreeItem extends Sprite implements Disposeable
   {
       
      
      private var _label:FilterFrameText;
      
      private var _cell:BaseCell;
      
      private var _btn:SimpleBitmapButton;
      
      private var _alreadyGet:Bitmap;
      
      private var _index:int;
      
      private var _num:int;
      
      private var _rewardId:int;
      
      public function WishingTreeItem(param1:int, param2:int, param3:int){super();}
      
      private function initView() : void{}
      
      private function addEvents() : void{}
      
      protected function __btnClick(param1:MouseEvent) : void{}
      
      public function setState(param1:int, param2:int) : void{}
      
      private function removeEvents() : void{}
      
      public function dispose() : void{}
   }
}
