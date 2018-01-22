package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.views.IRightView;
   
   public class FarmView extends Sprite implements IRightView
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      private var _back:Bitmap;
      
      private var endData:Date;
      
      private var nowdate:Date;
      
      private var _timerTxt:FilterFrameText;
      
      public function FarmView()
      {
         super();
      }
      
      public function init() : void
      {
         _back = ComponentFactory.Instance.creat("wonderfulactivity.farme.backgroud");
         addChild(_back);
         _btn = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.farmeBtn");
         addChild(_btn);
         _btn.addEventListener("click",mouseClickHander);
         _timerTxt = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.farmetimeTxt");
         addChild(_timerTxt);
         initTimer();
      }
      
      public function setState(param1:int, param2:int) : void
      {
      }
      
      private function initTimer() : void
      {
         endData = WonderfulActivityManager.Instance.chickenEndTime;
         if(!endData)
         {
            endData = new Date(2013,5,5);
         }
         farmeTimerHander();
         WonderfulActivityManager.Instance.addTimerFun("farme",farmeTimerHander);
      }
      
      private function farmeTimerHander() : void
      {
         nowdate = TimeManager.Instance.Now();
         var _loc1_:String = WonderfulActivityManager.Instance.getTimeDiff(endData,nowdate);
         _timerTxt.text = _loc1_;
      }
      
      protected function mouseClickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendNewChickenBox();
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         WonderfulActivityManager.Instance.delTimerFun("farme");
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
