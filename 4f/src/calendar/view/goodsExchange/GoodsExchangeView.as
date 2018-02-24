package calendar.view.goodsExchange
{
   import activeEvents.data.ActiveEventsInfo;
   import calendar.CalendarManager;
   import calendar.event.CalendarEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.GoodsExchangeInfo;
   import ddt.data.SendGoodsExchangeInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   
   public class GoodsExchangeView extends Sprite implements Disposeable
   {
      
      private static var HAVE_GOODS_CELL_COUNT:int = 8;
      
      private static var EXCHANGE_GOODS_CELL_COUNT:int = 6;
       
      
      private var _time:Bitmap;
      
      private var _actTimeText:FilterFrameText;
      
      private var _actTime:FilterFrameText;
      
      private var _haveImg:Bitmap;
      
      private var _haveGoodsExplain:FilterFrameText;
      
      private var _haveGoodsBox:SimpleTileList;
      
      private var _line:Bitmap;
      
      private var _exchangImg:Bitmap;
      
      private var _exchangGoodsExplain:FilterFrameText;
      
      private var _exchangGoodsCountText:FilterFrameText;
      
      private var _exchangGoodsCount:FilterFrameText;
      
      private var _awardBtnGroup:SelectedButtonGroup;
      
      private var _awardBtn1:SelectedButton;
      
      private var _awardBtn2:SelectedButton;
      
      private var _awardBtn3:SelectedButton;
      
      private var _awardBtn4:SelectedButton;
      
      private var _exchangGoodsBox:SimpleTileList;
      
      private var _awardBg1:MutipleImage;
      
      private var _awardBg2:Scale9CornerImage;
      
      private var _textBg:Scale9CornerImage;
      
      private var _goodsExchangeInfoVector:Vector.<GoodsExchangeInfo>;
      
      private var _count:int = 1;
      
      private var _haveGoodsCount:int;
      
      private var _activeEventsInfo:ActiveEventsInfo;
      
      private var _awardIndex:int = 0;
      
      private var _cellVector:Vector.<GoodsExchangeCell>;
      
      private var _ifNoneGoods:Boolean;
      
      public function GoodsExchangeView(){super();}
      
      private function initView() : void{}
      
      private function showTime() : void{}
      
      private function haveGoods() : void{}
      
      private function exchangGoods() : void{}
      
      private function initEvent() : void{}
      
      private function __clickBtn(param1:MouseEvent) : void{}
      
      private function __changeHandler(param1:Event) : void{}
      
      private function __countClickHandler(param1:MouseEvent) : void{}
      
      private function __countOnKeyDown(param1:KeyboardEvent) : void{}
      
      private function __countChangeHandler(param1:Event) : void{}
      
      public function setData(param1:ActiveEventsInfo) : void{}
      
      private function updateTimeShow() : void{}
      
      private function addZero(param1:Number) : String{return null;}
      
      private function updateHaveGoodsBox(param1:int) : void{}
      
      private function updateExchangeGoodsBox(param1:int) : void{}
      
      private function cleanCell() : void{}
      
      public function sendGoods() : void{}
      
      private function getLeastCount(param1:GoodsExchangeCell) : void{}
      
      private function get count() : int{return 0;}
      
      private function set count(param1:int) : void{}
      
      private function checkBtn() : void{}
      
      private function removeView() : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
