package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import consortion.event.ConsortionEvent;
   import consortion.view.selfConsortia.consortiaTask.ConsortiaTaskView;
   import ddt.data.ConsortiaEventInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import road7th.utils.StringHelper;
   
   public class PlacardAndEvent extends Sprite implements Disposeable
   {
       
      
      private var _taskBtn:SelectedTextButton;
      
      private var _placardBtn:SelectedTextButton;
      
      private var _eventBtn:SelectedTextButton;
      
      private var _weekRewardBtn:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _BG:MutipleImage;
      
      private var _placard:TextArea;
      
      private var _editBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _vote:BaseButton;
      
      private var _vbox:VBox;
      
      private var _eventPanel:ScrollPanel;
      
      private var _lastPlacard:String;
      
      private var _myTaskView:ConsortiaTaskView;
      
      private var _consortionRewardSp:ConsortionRewardSp;
      
      public function PlacardAndEvent(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __voteHandler(param1:MouseEvent) : void{}
      
      private function upPlacard() : void{}
      
      private function __btnClickHandler(param1:MouseEvent) : void{}
      
      private function __groupChangeHandler(param1:Event) : void{}
      
      private function showPlacardOrEvent(param1:int) : void{}
      
      private function __eventChangeHandler(param1:ConsortionEvent) : void{}
      
      private function __editHandler(param1:MouseEvent) : void{}
      
      private function __cancelHandler(param1:MouseEvent) : void{}
      
      private function __isClearHandler(param1:MouseEvent) : void{}
      
      private function __inputHandler(param1:Event) : void{}
      
      private function __placardChangeHandler(param1:PlayerPropertyEvent) : void{}
      
      private function __rightChangeHandler(param1:PlayerPropertyEvent) : void{}
      
      public function dispose() : void{}
   }
}
