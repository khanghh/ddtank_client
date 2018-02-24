package newChickenBox.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   import newChickenBox.model.NewChickenBoxModel;
   
   public class NewChickenBoxView extends Sprite implements Disposeable
   {
      
      private static const NUM:int = 18;
       
      
      private var _model:NewChickenBoxModel;
      
      private var eyeItem:NewChickenBoxItem;
      
      private var frame:BaseAlerFrame;
      
      private var moveBackArr:Array;
      
      public function NewChickenBoxView(){super();}
      
      private function init() : void{}
      
      public function getAllItem() : void{}
      
      private function openAlertFrame(param1:NewChickenBoxItem) : BaseAlerFrame{return null;}
      
      private function noAlertEable(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function openAlertFrame2(param1:NewChickenBoxItem) : BaseAlerFrame{return null;}
      
      private function noAlertEable2(param1:MouseEvent) : void{}
      
      private function __onResponse2(param1:FrameEvent) : void{}
      
      public function getItemEvent(param1:NewChickenBoxItem) : void{}
      
      public function removeItemEvent(param1:NewChickenBoxItem) : void{}
      
      public function tackoverCard(param1:MouseEvent) : void{}
      
      private function getNum(param1:int) : int{return 0;}
      
      public function updataAllItem() : void{}
      
      public function dispose() : void{}
   }
}
