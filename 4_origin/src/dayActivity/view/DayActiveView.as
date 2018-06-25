package dayActivity.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActiveData;
   import dayActivity.DayActivityControl;
   import dayActivity.DayActivityManager;
   import dayActivity.items.DayActivieListItem;
   import dayActivity.items.DayActivieTitle;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class DayActiveView extends Sprite implements Disposeable
   {
       
      
      private var _title:DayActivieTitle;
      
      private var _list:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _treeImage2:Scale9CornerImage;
      
      private var _itemList:Vector.<DayActivieListItem>;
      
      private var _bitMap:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _dataList:Vector.<DayActiveData>;
      
      private var _timer:TimerJuggler;
      
      private var _backGround:Bitmap;
      
      public function DayActiveView(dataList:Vector.<DayActiveData>)
      {
         super();
         _dataList = dataList;
         initView();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var str:* = null;
         var j:int = 0;
         _timer = TimerManager.getInstance().addTimerJuggler(10000);
         _timer.start();
         _timer.addEventListener("timer",timerHander);
         var len:int = _dataList.length;
         _itemList = new Vector.<DayActivieListItem>();
         _backGround = ComponentFactory.Instance.creat("day.actiity.groundBack");
         _backGround.x = 22;
         _backGround.y = 82;
         addChild(_backGround);
         _list = ComponentFactory.Instance.creatComponentByStylename("caddy.luckpaihangBox");
         _list.spacing = 1;
         _panel = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.left.scrollpanel");
         _panel.x = 28;
         _panel.y = 126;
         _panel.width = 713;
         _panel.height = 330;
         _panel.setView(_list);
         addChild(_panel);
         for(i = 0; i < len; )
         {
            item = new DayActivieListItem(i);
            item.setData(_dataList[i]);
            item.seleLigthFun = seletLight;
            str = _dataList[i].ActiveTime.slice(0,7);
            if(str == "Cả ngày")
            {
               item.initTxt(false);
            }
            else
            {
               item.initTxt(true);
            }
            item.y = (item.height + 1) * i;
            _list.addChild(item);
            _itemList.push(item);
            i++;
         }
         _txt = ComponentFactory.Instance.creatComponentByStylename("day.activieView.txt");
         addChild(_txt);
         DayActivityControl.Instance.initActivityStata(_itemList);
         _itemList = updataList(_itemList);
         for(j = 0; j < _itemList.length; )
         {
            _itemList[j].y = (_itemList[j].height + 1) * j;
            _itemList[j].setBg(j);
            _list.addChild(_itemList[j]);
            j++;
         }
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.leavlOver20") + _itemList[0].data.LevelLimit;
         updata(DayActivityManager.Instance.sessionArr);
         _itemList[0].setLigthVisible(true);
         _panel.invalidateViewport();
      }
      
      private function seletLight(dailyItem:DayActivieListItem, lv:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _itemList;
         for each(var tmpItem in _itemList)
         {
            if(tmpItem == dailyItem)
            {
               tmpItem.setLigthVisible(true);
            }
            else
            {
               tmpItem.setLigthVisible(false);
            }
         }
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.leavlOver20") + lv;
      }
      
      private function updataList(_lists:Vector.<DayActivieListItem>) : Vector.<DayActivieListItem>
      {
         var i:int = 0;
         var j:int = 0;
         var len:int = _lists.length;
         var openList:Vector.<DayActivieListItem> = new Vector.<DayActivieListItem>();
         var closeList:Vector.<DayActivieListItem> = new Vector.<DayActivieListItem>();
         for(i = 0; i < len; )
         {
            if(_lists[i].getTxt5str() == LanguageMgr.GetTranslation("ddt.dayActivity.close"))
            {
               closeList.push(_lists[i]);
            }
            else
            {
               openList.push(_lists[i]);
            }
            i++;
         }
         for(j = 0; j < closeList.length; )
         {
            openList.push(closeList[j]);
            j++;
         }
         return openList;
      }
      
      public function updata(arr:Array) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(arr == null)
         {
            return;
         }
         var len:int = arr.length;
         for(i = 0; i < len; )
         {
            for(j = 0; j < _itemList.length; )
            {
               if(arr[i])
               {
                  if(arr[i][0] == _itemList[j].id)
                  {
                     _itemList[j].updataCount(arr[i][1]);
                     break;
                  }
               }
               j++;
            }
            i++;
         }
      }
      
      protected function timerHander(event:Event) : void
      {
         var j:int = 0;
         DayActivityControl.Instance.initActivityStata(_itemList);
         updata(DayActivityManager.Instance.sessionArr);
         _itemList = updataList(_itemList);
         for(j = 0; j < _itemList.length; )
         {
            _itemList[j].y = (_itemList[j].height + 1) * j;
            _itemList[j].setBg(j);
            _list.addChild(_itemList[j]);
            j++;
         }
      }
      
      public function upDataList() : void
      {
         clearList();
      }
      
      private function clearList() : void
      {
         while(_list && _list.numChildren)
         {
            ObjectUtils.disposeObject(_list.getChildAt(0));
         }
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHander);
            TimerManager.getInstance().removeJugglerByTimer(_timer);
         }
         _timer = null;
         clearList();
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _list = null;
         _panel = null;
         _itemList = null;
      }
   }
}
