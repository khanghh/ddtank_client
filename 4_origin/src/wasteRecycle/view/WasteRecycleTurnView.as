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
         var i:int = 0;
         _list = new Vector.<WasteRecycleTurnItem>(3);
         var pos:Array = [0,107,213];
         for(i = 0; i < 3; )
         {
            _list[i] = new WasteRecycleTurnItem();
            _list[i].x = pos[i];
            _list[i].addEventListener("playComplete",__onPlayComplete);
            _list[i].addEventListener("shineComplete",__onShineComplete);
            addChild(_list[i]);
            i++;
         }
         _timer = new Timer(500,3);
         _timer.addEventListener("timer",__onTimer,false,0,true);
      }
      
      public function playAction(type:int, str:String) : void
      {
         _playCount = 0;
         setPlayLabel(type);
         _str = str;
         _timer.reset();
         _timer.start();
      }
      
      private function setPlayLabel(type:int) : void
      {
         var random1:int = 0;
         var random2:int = 0;
         var random3:int = 0;
         while(random1 == random2 || random1 == random3 || random2 == random3)
         {
            random1 = int(Math.random() * 14) + 1;
            random2 = int(Math.random() * 14) + 1;
            random3 = int(Math.random() * 14) + 1;
         }
         if(type == 1)
         {
            _playLabel = [random1,random2,random3];
         }
         else if(type == 2)
         {
            _playLabel = [random1,random1,random2];
         }
         else if(type == 3)
         {
            _playLabel = [random1,random1,random1];
         }
         var index:int = _playLabel.length;
         while(true)
         {
            index--;
            if(!index)
            {
               break;
            }
            _playLabel.push(_playLabel.splice(int(Math.random() * _playLabel.length),1));
         }
      }
      
      private function __onTimer(e:Event) : void
      {
         var index:int = _timer.currentCount - 1;
         _list[index].turn(_playLabel[index]);
      }
      
      private function __onPlayComplete(e:Event) : void
      {
         var i:int = 0;
         _playCount = Number(_playCount) + 1;
         if(Number(_playCount) >= 2)
         {
            _playCount = 0;
            for(i = 0; i < _list.length; )
            {
               _list[i].shine();
               i++;
            }
         }
      }
      
      private function __onShineComplete(e:Event) : void
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
         var item:* = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
         }
         while(_list.length)
         {
            item = _list.pop();
            item.removeEventListener("playComplete",__onPlayComplete);
            item.removeEventListener("shineComplete",__onShineComplete);
         }
         ObjectUtils.disposeAllChildren(this);
         _list = null;
         _timer = null;
         _str = null;
      }
   }
}
