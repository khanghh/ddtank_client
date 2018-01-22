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
      
      public function DayActiveView(param1:Vector.<DayActiveData>)
      {
         super();
         _dataList = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc4_:int = 0;
         _timer = TimerManager.getInstance().addTimerJuggler(10000);
         _timer.start();
         _timer.addEventListener("timer",timerHander);
         var _loc3_:int = _dataList.length;
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
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = new DayActivieListItem(_loc5_);
            _loc2_.setData(_dataList[_loc5_]);
            _loc2_.seleLigthFun = seletLight;
            _loc1_ = _dataList[_loc5_].ActiveTime.slice(0,7);
            if(_loc1_ == "Cả ngày")
            {
               _loc2_.initTxt(false);
            }
            else
            {
               _loc2_.initTxt(true);
            }
            _loc2_.y = (_loc2_.height + 1) * _loc5_;
            _list.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc5_++;
         }
         _txt = ComponentFactory.Instance.creatComponentByStylename("day.activieView.txt");
         addChild(_txt);
         DayActivityControl.Instance.initActivityStata(_itemList);
         _itemList = updataList(_itemList);
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _itemList[_loc4_].y = (_itemList[_loc4_].height + 1) * _loc4_;
            _itemList[_loc4_].setBg(_loc4_);
            _list.addChild(_itemList[_loc4_]);
            _loc4_++;
         }
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.leavlOver20") + _itemList[0].data.LevelLimit;
         updata(DayActivityManager.Instance.sessionArr);
         _itemList[0].setLigthVisible(true);
         _panel.invalidateViewport();
      }
      
      private function seletLight(param1:DayActivieListItem, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _itemList;
         for each(var _loc3_ in _itemList)
         {
            if(_loc3_ == param1)
            {
               _loc3_.setLigthVisible(true);
            }
            else
            {
               _loc3_.setLigthVisible(false);
            }
         }
         _txt.text = LanguageMgr.GetTranslation("ddt.dayActivity.leavlOver20") + param2;
      }
      
      private function updataList(param1:Vector.<DayActivieListItem>) : Vector.<DayActivieListItem>
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = param1.length;
         var _loc2_:Vector.<DayActivieListItem> = new Vector.<DayActivieListItem>();
         var _loc3_:Vector.<DayActivieListItem> = new Vector.<DayActivieListItem>();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(param1[_loc6_].getTxt5str() == LanguageMgr.GetTranslation("ddt.dayActivity.close"))
            {
               _loc3_.push(param1[_loc6_]);
            }
            else
            {
               _loc2_.push(param1[_loc6_]);
            }
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc2_.push(_loc3_[_loc5_]);
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function updata(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _itemList.length)
            {
               if(param1[_loc4_])
               {
                  if(param1[_loc4_][0] == _itemList[_loc3_].id)
                  {
                     _itemList[_loc3_].updataCount(param1[_loc4_][1]);
                     break;
                  }
               }
               _loc3_++;
            }
            _loc4_++;
         }
      }
      
      protected function timerHander(param1:Event) : void
      {
         var _loc2_:int = 0;
         DayActivityControl.Instance.initActivityStata(_itemList);
         updata(DayActivityManager.Instance.sessionArr);
         _itemList = updataList(_itemList);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _itemList[_loc2_].y = (_itemList[_loc2_].height + 1) * _loc2_;
            _itemList[_loc2_].setBg(_loc2_);
            _list.addChild(_itemList[_loc2_]);
            _loc2_++;
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
