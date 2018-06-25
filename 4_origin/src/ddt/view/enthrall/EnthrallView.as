package ddt.view.enthrall
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import ddt.manager.EnthrallManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class EnthrallView extends Component
   {
      
      public static const HALL_VIEW_STATE:uint = 0;
      
      public static const ROOMLIST_VIEW_STATE:uint = 1;
      
      public static const GAME_VIEW_STATE:uint = 2;
       
      
      private var _enthrall:ScaleFrameImage;
      
      private var _enthrallBall:ScaleFrameImage;
      
      private var _info:TimeTip;
      
      private var _approveBtn:SimpleBitmapButton;
      
      private var _manager:EnthrallManager;
      
      public function EnthrallView()
      {
         super();
      }
      
      public function set manager(manager:EnthrallManager) : void
      {
         _manager = manager;
         initUI();
      }
      
      private function initUI() : void
      {
         _enthrall = ComponentFactory.Instance.creat("core.view.enthrall.InfoNormal");
         _enthrall.setFrame(1);
         addChild(_enthrall);
         _approveBtn = ComponentFactory.Instance.creat("core.view.enthrall.ValidateBtn");
         addChild(_approveBtn);
         _enthrallBall = ComponentFactory.Instance.creat("core.view.enthrall.InfoBall");
         _info = ComponentFactory.Instance.creat("EnthrallTip");
         _info.visible = false;
         _info.info_txt.text = "";
         addChild(_info);
         addEvent();
      }
      
      private function addEvent() : void
      {
         TimeManager.addEventListener(TimeManager.CHANGE,__changeHandler);
         _enthrall.addEventListener("mouseOver",__mouseOverHandler);
         _enthrall.addEventListener("mouseOut",__mouseOutHandler);
         _enthrallBall.addEventListener("mouseOver",__mouseOverHandler);
         _enthrallBall.addEventListener("mouseOut",__mouseOutHandler);
         _approveBtn.addEventListener("click",popFrame);
      }
      
      private function popFrame(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _manager.showCIDCheckerFrame();
      }
      
      public function update() : void
      {
         upGameTimeStatus();
      }
      
      private function __changeHandler(evt:Event) : void
      {
         if(this.parent == null || this.visible == false)
         {
            return;
         }
         upGameTimeStatus();
      }
      
      private function __mouseOverHandler(evt:MouseEvent) : void
      {
         upGameTimeStatus();
         _info.visible = true;
      }
      
      private function upGameTimeStatus() : void
      {
         var time:Number = TimeManager.Instance.totalGameTime;
         _info.info_txt.text = getTimeTxt(time);
         setViewState(time);
      }
      
      private function getTimeTxt(time:Number) : String
      {
         var hours:Number = Math.floor(time / 60);
         var min:Number = Math.floor(time % 60);
         var str:String = (min < 10?hours + ":0" + min:hours + ":" + min) + " / 5:00";
         return str;
      }
      
      private function __mouseOutHandler(evt:MouseEvent) : void
      {
         _info.info_txt.text = "";
         setViewState(TimeManager.Instance.totalGameTime);
         _info.visible = false;
      }
      
      private function setViewState(time:Number) : void
      {
         var minute:Number = Math.floor(time);
         if(minute < 180)
         {
            _enthrall.setFrame(1);
            _enthrallBall.setFrame(1);
         }
         else if(minute < 300)
         {
            _enthrall.setFrame(2);
            _enthrallBall.setFrame(2);
         }
         else if(minute > 300)
         {
            _enthrall.setFrame(3);
            _enthrallBall.setFrame(3);
         }
      }
      
      public function show(view:EnthrallView) : void
      {
         setViewState(TimeManager.Instance.totalGameTime);
      }
      
      public function changeBtn(showBtn:Boolean) : void
      {
         _approveBtn.visible = showBtn;
      }
      
      public function changeToGameState(flag:Boolean) : void
      {
         _enthrallBall.visible = flag;
         _enthrall.visible = !flag;
         _approveBtn.visible = !flag;
      }
      
      private function removeEvent() : void
      {
         TimeManager.removeEventListener(TimeManager.CHANGE,__changeHandler);
         _enthrall.removeEventListener("mouseOver",__mouseOverHandler);
         _enthrall.removeEventListener("mouseOut",__mouseOutHandler);
         _enthrallBall.removeEventListener("mouseOver",__mouseOverHandler);
         _enthrallBall.removeEventListener("mouseOut",__mouseOutHandler);
         _approveBtn.removeEventListener("click",popFrame);
      }
      
      override public function dispose() : void
      {
      }
      
      public function get enthrall() : ScaleFrameImage
      {
         return _enthrall;
      }
   }
}
