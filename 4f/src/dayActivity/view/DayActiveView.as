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
      
      public function DayActiveView(param1:Vector.<DayActiveData>){super();}
      
      private function initView() : void{}
      
      private function seletLight(param1:DayActivieListItem, param2:int) : void{}
      
      private function updataList(param1:Vector.<DayActivieListItem>) : Vector.<DayActivieListItem>{return null;}
      
      public function updata(param1:Array) : void{}
      
      protected function timerHander(param1:Event) : void{}
      
      public function upDataList() : void{}
      
      private function clearList() : void{}
      
      public function dispose() : void{}
   }
}
