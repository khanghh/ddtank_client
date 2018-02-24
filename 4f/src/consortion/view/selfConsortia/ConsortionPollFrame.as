package consortion.view.selfConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import consortion.ConsortionModelManager;
   import consortion.data.ConsortionPollInfo;
   import consortion.event.ConsortionEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class ConsortionPollFrame extends Frame
   {
       
      
      private var _bg:MutipleImage;
      
      private var _name:FilterFrameText;
      
      private var _ticketCount:FilterFrameText;
      
      private var _vote:BaseButton;
      
      private var _help:BaseButton;
      
      private var _mark:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _items:Vector.<ConsortionPollItem>;
      
      private var _currentItem:ConsortionPollItem;
      
      private var _helpFrame:Frame;
      
      private var _helpContentBG:Scale9CornerImage;
      
      private var _helpContent:MovieImage;
      
      private var _helpClose:TextButton;
      
      public function ConsortionPollFrame(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __consortiaPollHandler(param1:PkgEvent) : void{}
      
      private function __pollListChange(param1:ConsortionEvent) : void{}
      
      private function clearList() : void{}
      
      private function set dataList(param1:Vector.<ConsortionPollInfo>) : void{}
      
      private function __itemClickHandler(param1:MouseEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __voteHandler(param1:MouseEvent) : void{}
      
      private function __helpHandler(param1:MouseEvent) : void{}
      
      private function __helpResoponseHandler(param1:FrameEvent) : void{}
      
      private function __closeHelpHandler(param1:MouseEvent) : void{}
      
      private function helpDispose() : void{}
      
      override public function dispose() : void{}
   }
}
