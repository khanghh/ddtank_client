package gameCommon.objects
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import room.RoomManager;
   
   public class ActivityDungeonNextView extends Sprite
   {
       
      
      private var ACTIVITYDUNGEONPOINTSNUM:String = "asset.game.nextView.count_";
      
      private var _bg:Bitmap;
      
      private var _nextBtn:BaseButton;
      
      private var _pointsNum:Sprite;
      
      private var _numBitmapArray:Array;
      
      private var _cdData:Number = 0;
      
      private var _timer:Timer;
      
      private var _id:int;
      
      private var _offX:int = 8;
      
      public function ActivityDungeonNextView(id:int, time:Number)
      {
         super();
         _id = id;
         _cdData = (time - TimeManager.Instance.Now().time) / 1000;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         mouseChildren = true;
         _bg = ComponentFactory.Instance.creat("asset.game.nextView.bg");
         addChild(_bg);
         _nextBtn = ComponentFactory.Instance.creat("activyDungeon.nextView.btn");
         addChild(_nextBtn);
         _pointsNum = new Sprite();
         PositionUtils.setPos(_pointsNum,"game.view.activityDungeonNextView.pointsNumPos");
         addChild(_pointsNum);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
         setCountDownNumber(_cdData);
      }
      
      protected function __onTimer(event:TimerEvent) : void
      {
         if(_cdData > 0)
         {
            _cdData = Number(_cdData) - 1;
            setCountDownNumber(_cdData);
         }
         else
         {
            _timer.stop();
            this.visible = false;
         }
      }
      
      private function setCountDownNumber(points:int) : void
      {
         var bitmap:* = null;
         var i:int = 0;
         var pointsStr:String = (String("0" + Math.floor(points))).substr(-2);
         var num:String = "";
         deleteBitmapArray();
         _numBitmapArray = [];
         for(i = 0; i < pointsStr.length; )
         {
            num = pointsStr.charAt(i);
            bitmap = ComponentFactory.Instance.creatBitmap(ACTIVITYDUNGEONPOINTSNUM + num);
            bitmap.x = bitmap.bitmapData.width * i - (i == 0?0:_offX);
            _pointsNum.addChild(bitmap);
            _numBitmapArray.push(bitmap);
            i++;
         }
      }
      
      private function deleteBitmapArray() : void
      {
         var i:int = 0;
         if(_numBitmapArray)
         {
            for(i = 0; i < _numBitmapArray.length; )
            {
               _numBitmapArray[i].bitmapData.dispose();
               _numBitmapArray[i] = null;
               i++;
            }
            _numBitmapArray.length = 0;
            _numBitmapArray = null;
         }
      }
      
      private function initEvent() : void
      {
         _nextBtn.addEventListener("click",__onMouseClick);
      }
      
      public function setBtnEnable() : void
      {
         _nextBtn.enable = false;
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         if(RoomManager.Instance.current.type != 49)
         {
            _timer.stop();
            SocketManager.Instance.out.sendActivityDungeonNextPoints(_id,true);
         }
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onMouseClick);
            _nextBtn.dispose();
            _nextBtn = null;
         }
         deleteBitmapArray();
         if(_pointsNum)
         {
            _pointsNum = null;
         }
         if(_timer)
         {
            _timer.reset();
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
      }
      
      public function get Id() : int
      {
         return _id;
      }
   }
}
