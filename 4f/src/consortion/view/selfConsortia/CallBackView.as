package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import consortion.ConsortionModelManager;
   import consortion.data.CallBackModel;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CallBackView extends Sprite implements Disposeable
   {
       
      
      private var _backBtn:SimpleBitmapButton;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _isOpen:Boolean;
      
      private var _callBackModel:CallBackModel;
      
      public function CallBackView(){super();}
      
      private function onQueryConsortionCallBackInfo(param1:Event) : void{}
      
      private function initView() : void{}
      
      private function updateScrollPanel() : void{}
      
      private function onGetConsortionCallBackAward(param1:Event) : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function onClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
