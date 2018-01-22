package wasteRecycle.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Timer;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecycleTurnView extends Sprite implements Disposeable
   {
       
      
      private var _list:Vector.<WasteRecycleTurnItem>;
      
      private var _timer:Timer;
      
      private var _playLabel:Array;
      
      private var _str:String;
      
      private var _playCount:int;
      
      public function WasteRecycleTurnView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         _list = new Vector.<WasteRecycleTurnItem>(3);
         var _loc2_:Array = [0,107,213];
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            _list[_loc1_] = new WasteRecycleTurnItem();
            _list[_loc1_].x = _loc2_[_loc1_];
            _list[_loc1_].addEventListener("playComplete",__onPlayComplete);
            _list[_loc1_].addEventListener("shineComplete",__onShineComplete);
            addChild(_list[_loc1_]);
            _loc1_++;
         }
         _timer = new Timer(500,3);
         _timer.addEventListener("timer",__onTimer,false,0,true);
      }
      
      public function playAction(param1:int, param2:String) : void
      {
         _playCount = 0;
         setPlayLabel(param1);
         _str = param2;
         _timer.reset();
         _timer.start();
      }
      
      private function setPlayLabel(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         while(_loc4_ == _loc3_ || _loc4_ == _loc5_ || _loc3_ == _loc5_)
         {
            _loc4_ = int(Math.random() * 14) + 1;
            _loc3_ = int(Math.random() * 14) + 1;
            _loc5_ = int(Math.random() * 14) + 1;
         }
         if(param1 == 1)
         {
            _playLabel = [_loc4_,_loc3_,_loc5_];
         }
         else if(param1 == 2)
         {
            _playLabel = [_loc4_,_loc4_,_loc3_];
         }
         else if(param1 == 3)
         {
            _playLabel = [_loc4_,_loc4_,_loc4_];
         }
         var _loc2_:int = _playLabel.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _playLabel.push(_playLabel.splice(int(Math.random() * _playLabel.length),1));
         }
      }
      
      private function __onTimer(param1:Event) : void
      {
         var _loc2_:int = _timer.currentCount - 1;
         _list[_loc2_].turn(_playLabel[_loc2_]);
      }
      
      private function __onPlayComplete(param1:Event) : void
      {
         var _loc2_:int = 0;
         _playCount = Number(_playCount) + 1;
         if(Number(_playCount) >= 2)
         {
            _playCount = 0;
            _loc2_ = 0;
            while(_loc2_ < _list.length)
            {
               _list[_loc2_].shine();
               _loc2_++;
            }
         }
      }
      
      private function __onShineComplete(param1:Event) : void
      {
         _playCount = Number(_playCount) + 1;
         if(Number(_playCount) >= 2)
         {
            _playCount = 0;
            WasteRecycleController.instance.isPlay = false;
            WasteRecycleController.instance.dispatchEvent(new Event("complete"));
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.wasteRecycle.gainGoodsTips",_str));
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
         }
         while(_list.length)
         {
            _loc1_ = _list.pop();
            _loc1_.removeEventListener("playComplete",__onPlayComplete);
            _loc1_.removeEventListener("shineComplete",__onShineComplete);
         }
         ObjectUtils.disposeAllChildren(this);
         _list = null;
         _timer = null;
         _str = null;
      }
   }
}
