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
      
      public function GoodsExchangeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         showTime();
         haveGoods();
         exchangGoods();
      }
      
      private function showTime() : void
      {
         _time = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.TimeIcon");
         PositionUtils.setPos(_time,"ddtcalendar.GoodsExchangeView.timeImgPos");
         addChild(_time);
         _actTimeText = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.actTimeText");
         _actTimeText.text = LanguageMgr.GetTranslation("tank.calendar.GoodsExchangeView.actTimeText");
         addChild(_actTimeText);
         _actTime = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.actTime");
         addChild(_actTime);
      }
      
      private function haveGoods() : void
      {
         _haveImg = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.AwardIcon");
         PositionUtils.setPos(_haveImg,"ddtcalendar.GoodsExchangeView.HaveImgPos");
         _haveGoodsExplain = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.haveGoodsExplain");
         _haveGoodsExplain.text = LanguageMgr.GetTranslation("tank.calendar.GoodsExchangeView.haveGoodsExplainText");
         addChild(_haveGoodsExplain);
         _haveGoodsBox = ComponentFactory.Instance.creatCustomObject("ddtcalendar.exchange.haveGoodsBox",[4]);
         addChild(_haveGoodsBox);
         _line = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.SeparatorLine");
         PositionUtils.setPos(_line,"ddtcalendar.exchange.LinePos");
         addChild(_line);
      }
      
      private function exchangGoods() : void
      {
         _awardBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardBack");
         addChild(_awardBg1);
         _awardBg2 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardScoreBg");
         addChild(_awardBg2);
         _textBg = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.TextFieldBg");
         addChild(_textBg);
         _exchangImg = ComponentFactory.Instance.creatBitmap("asset.ddtcalendar.ActivityState.ContentIcon");
         PositionUtils.setPos(_exchangImg,"ddtcalendar.GoodsExchangeView.changeImgPos");
         addChild(_exchangImg);
         _exchangGoodsExplain = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.changeGoodsExplain");
         _exchangGoodsExplain.text = LanguageMgr.GetTranslation("tank.calendar.GoodsExchangeView.changeGoodsExplainText");
         addChild(_exchangGoodsExplain);
         _exchangGoodsCountText = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.changeGoodsCountText");
         _exchangGoodsCountText.text = LanguageMgr.GetTranslation("tank.calendar.GoodsExchangeView.changeGoodsCountText");
         addChild(_exchangGoodsCountText);
         _exchangGoodsCount = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.changeGoodsCount");
         _exchangGoodsCount.text = "1";
         _exchangGoodsCount.restrict = "0-9";
         addChild(_exchangGoodsCount);
         _awardBtnGroup = new SelectedButtonGroup();
         _awardBtn1 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardBtn1");
         addChild(_awardBtn1);
         _awardBtn2 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardBtn2");
         addChild(_awardBtn2);
         _awardBtn3 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardBtn3");
         addChild(_awardBtn3);
         _awardBtn4 = ComponentFactory.Instance.creatComponentByStylename("ddtcalendar.GoodsExchangeView.awardBtn4");
         addChild(_awardBtn4);
         _awardBtnGroup.addSelectItem(_awardBtn1);
         _awardBtnGroup.addSelectItem(_awardBtn2);
         _awardBtnGroup.addSelectItem(_awardBtn3);
         _awardBtnGroup.addSelectItem(_awardBtn4);
         _awardBtnGroup.selectIndex = 0;
         _exchangGoodsBox = ComponentFactory.Instance.creatCustomObject("ddtcalendar.exchange.exchangeGoodsBox",[6]);
         addChild(_exchangGoodsBox);
      }
      
      private function initEvent() : void
      {
         _awardBtn1.addEventListener("click",__clickBtn);
         _awardBtn2.addEventListener("click",__clickBtn);
         _awardBtn3.addEventListener("click",__clickBtn);
         _awardBtn4.addEventListener("click",__clickBtn);
         _exchangGoodsCount.addEventListener("click",__countClickHandler);
         _exchangGoodsCount.addEventListener("keyDown",__countOnKeyDown);
         _exchangGoodsCount.addEventListener("change",__countChangeHandler);
      }
      
      private function __clickBtn(event:MouseEvent) : void
      {
         _exchangGoodsCount.text = "1";
         this.count = 0;
         SoundManager.instance.play("008");
         _awardIndex = _awardBtnGroup.selectIndex;
      }
      
      private function __changeHandler(event:Event) : void
      {
         var index:int = _awardBtnGroup.selectIndex;
         _haveGoodsCount = 0;
         updateHaveGoodsBox(index);
         updateExchangeGoodsBox(index);
      }
      
      private function __countClickHandler(event:MouseEvent) : void
      {
         event.stopImmediatePropagation();
      }
      
      private function __countOnKeyDown(event:KeyboardEvent) : void
      {
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
      }
      
      private function __countChangeHandler(event:Event) : void
      {
         var temp:* = null;
         if(_exchangGoodsCount.text == "")
         {
            _exchangGoodsCount.text = "1";
         }
         else if(_exchangGoodsCount.text != "0")
         {
            temp = _exchangGoodsCount.text.substr(0,1);
            if(temp == "0")
            {
               _exchangGoodsCount.text = _exchangGoodsCount.text.substring(1);
            }
         }
         if(int(_exchangGoodsCount.text) > _haveGoodsCount)
         {
            if(_haveGoodsCount == 0)
            {
               _exchangGoodsCount.text = "1";
            }
            else
            {
               _exchangGoodsCount.text = _haveGoodsCount.toString();
            }
         }
         this.count = int(_exchangGoodsCount.text);
      }
      
      public function setData(info:ActiveEventsInfo) : void
      {
         var i:int = 0;
         _activeEventsInfo = info;
         _goodsExchangeInfoVector = new Vector.<GoodsExchangeInfo>();
         var tempArray:Array = CalendarManager.getInstance().activeExchange;
         var count:int = tempArray.length;
         for(i = 0; i < count; )
         {
            if(_activeEventsInfo.ActiveID == tempArray[i].ActiveID)
            {
               _goodsExchangeInfoVector.push(tempArray[i]);
            }
            i++;
         }
         updateTimeShow();
         updateHaveGoodsBox(0);
         updateExchangeGoodsBox(0);
      }
      
      private function updateTimeShow() : void
      {
         var startDate:Date = DateUtils.getDateByStr(_activeEventsInfo.StartDate);
         var endDate:Date = DateUtils.getDateByStr(_activeEventsInfo.EndDate);
         _actTime.text = addZero(startDate.fullYear) + "." + addZero(startDate.month + 1) + "." + addZero(startDate.date);
         _actTime.text = _actTime.text + ("-" + addZero(endDate.fullYear) + "." + addZero(endDate.month + 1) + "." + addZero(endDate.date));
      }
      
      private function addZero(value:Number) : String
      {
         var result:* = null;
         if(value < 10)
         {
            result = "0" + value.toString();
         }
         else
         {
            result = value.toString();
         }
         return result;
      }
      
      private function updateHaveGoodsBox(index:int) : void
      {
         var i:int = 0;
         var cell:* = null;
         var j:* = 0;
         if(!_goodsExchangeInfoVector)
         {
            return;
         }
         _ifNoneGoods = false;
         cleanCell();
         _haveGoodsBox.disposeAllChildren();
         ObjectUtils.removeChildAllChildren(_haveGoodsBox);
         var count:int = _goodsExchangeInfoVector.length;
         var tempCount:int = 0;
         for(i = 0; i < count; )
         {
            if(_goodsExchangeInfoVector[i].ItemType == index * 2)
            {
               _goodsExchangeInfoVector[i].Num = this.count;
               cell = new GoodsExchangeCell(_goodsExchangeInfoVector[i]);
               getLeastCount(cell);
               _haveGoodsBox.addChild(cell);
               tempCount = tempCount + 1;
               _cellVector.push(cell);
            }
            i++;
         }
         if(tempCount < HAVE_GOODS_CELL_COUNT)
         {
            for(j = tempCount; j < HAVE_GOODS_CELL_COUNT; )
            {
               _haveGoodsBox.addChild(new GoodsExchangeCell(null));
               j++;
            }
         }
         if(tempCount == 0)
         {
            getLeastCount(null);
            _exchangGoodsCount.text = "0";
         }
         checkBtn();
      }
      
      private function updateExchangeGoodsBox(index:int) : void
      {
         var i:int = 0;
         var j:* = 0;
         if(!_goodsExchangeInfoVector)
         {
            return;
         }
         _exchangGoodsBox.disposeAllChildren();
         ObjectUtils.removeChildAllChildren(_exchangGoodsBox);
         var count:int = _goodsExchangeInfoVector.length;
         var tempCount:int = 0;
         for(i = 0; i < count; )
         {
            if(_goodsExchangeInfoVector[i].ItemType == index * 2 + 1)
            {
               _goodsExchangeInfoVector[i].Num = this.count;
               _exchangGoodsBox.addChild(new GoodsExchangeCell(_goodsExchangeInfoVector[i],_activeEventsInfo.ActiveType,false));
               tempCount = tempCount + 1;
            }
            i++;
         }
         if(count < EXCHANGE_GOODS_CELL_COUNT)
         {
            for(j = tempCount; j < EXCHANGE_GOODS_CELL_COUNT; )
            {
               _exchangGoodsBox.addChild(new GoodsExchangeCell(null));
               j++;
            }
         }
      }
      
      private function cleanCell() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cellVector;
         for each(var cell in _cellVector)
         {
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         _cellVector = new Vector.<GoodsExchangeCell>();
      }
      
      public function sendGoods() : void
      {
         var i:int = 0;
         var sendGoodsExchangeInfo:* = null;
         var boo:Boolean = false;
         var sendGoodsExchangeInfos:Vector.<SendGoodsExchangeInfo> = new Vector.<SendGoodsExchangeInfo>();
         for(i = 0; i < _cellVector.length; )
         {
            sendGoodsExchangeInfo = new SendGoodsExchangeInfo();
            if(!_cellVector[i].info || !_cellVector[i].itemInfo)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("calendar.view.goodsExchange.warningIII"));
               return;
            }
            sendGoodsExchangeInfo.id = _cellVector[i].info.TemplateID;
            sendGoodsExchangeInfo.place = _cellVector[i].itemInfo.Place;
            sendGoodsExchangeInfo.bagType = _cellVector[i].itemInfo.BagType;
            sendGoodsExchangeInfos.push(sendGoodsExchangeInfo);
            if(_cellVector[i].needCount - this.count <= 0)
            {
               boo = true;
            }
            i++;
         }
         _exchangGoodsCount.text = "1";
         SocketManager.Instance.out.sendGoodsExchange(sendGoodsExchangeInfos,_activeEventsInfo.ActiveID,this.count,_awardIndex);
         _count = 1;
         if(boo)
         {
            dispatchEvent(new CalendarEvent("ExchangeGoodsChange",false));
         }
      }
      
      private function getLeastCount(cell:GoodsExchangeCell) : void
      {
         if(cell == null)
         {
            _haveGoodsCount = 0;
            if(_count != 0)
            {
               _count = 0;
            }
            return;
         }
         var itemCount:int = cell.needCount;
         if(_ifNoneGoods == true)
         {
            return;
         }
         if(itemCount == 0)
         {
            _ifNoneGoods = true;
            _haveGoodsCount = 0;
         }
         else if(_haveGoodsCount == 0)
         {
            _haveGoodsCount = itemCount;
         }
         else
         {
            _haveGoodsCount = _haveGoodsCount > itemCount?itemCount:int(_haveGoodsCount);
         }
      }
      
      private function get count() : int
      {
         return _count;
      }
      
      private function set count(value:int) : void
      {
         _count = value == 0?1:value;
         __changeHandler(null);
      }
      
      private function checkBtn() : void
      {
         if(_haveGoodsCount == 0 || _exchangGoodsCount.text == "0")
         {
            dispatchEvent(new CalendarEvent("ExchangeGoodsChange",false));
         }
         else
         {
            dispatchEvent(new CalendarEvent("ExchangeGoodsChange",true));
         }
      }
      
      private function removeView() : void
      {
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
            _time = null;
         }
         if(_actTimeText)
         {
            ObjectUtils.disposeObject(_actTimeText);
            _actTimeText = null;
         }
         if(_actTime)
         {
            ObjectUtils.disposeObject(_actTime);
            _actTime = null;
         }
         if(_haveImg)
         {
            ObjectUtils.disposeObject(_haveImg);
            _haveImg = null;
         }
         if(_haveGoodsExplain)
         {
            ObjectUtils.disposeObject(_haveGoodsExplain);
            _haveGoodsExplain = null;
         }
         if(_haveGoodsBox)
         {
            ObjectUtils.disposeObject(_haveGoodsBox);
            _haveGoodsBox = null;
         }
         if(_line)
         {
            ObjectUtils.disposeObject(_line);
            _line = null;
         }
         if(_exchangImg)
         {
            ObjectUtils.disposeObject(_exchangImg);
            _exchangImg = null;
         }
         if(_exchangGoodsExplain)
         {
            ObjectUtils.disposeObject(_exchangGoodsExplain);
            _exchangGoodsExplain = null;
         }
         if(_exchangGoodsCountText)
         {
            ObjectUtils.disposeObject(_exchangGoodsCountText);
            _exchangGoodsCountText = null;
         }
         if(_exchangGoodsBox)
         {
            ObjectUtils.disposeObject(_exchangGoodsBox);
            _exchangGoodsBox = null;
         }
         if(_awardBg1)
         {
            ObjectUtils.disposeObject(_awardBg1);
            _awardBg1 = null;
         }
         if(_awardBg2)
         {
            ObjectUtils.disposeObject(_awardBg2);
            _awardBg2 = null;
         }
         if(_awardBtn1)
         {
            ObjectUtils.disposeObject(_awardBtn1);
            _awardBtn1 = null;
         }
         if(_awardBtn2)
         {
            ObjectUtils.disposeObject(_awardBtn2);
            _awardBtn2 = null;
         }
         if(_awardBtn3)
         {
            ObjectUtils.disposeObject(_awardBtn3);
            _awardBtn3 = null;
         }
         if(_awardBtn4)
         {
            ObjectUtils.disposeObject(_awardBtn4);
            _awardBtn4 = null;
         }
         if(_textBg)
         {
            ObjectUtils.disposeObject(_textBg);
            _textBg = null;
         }
      }
      
      private function removeEvent() : void
      {
         _awardBtnGroup.removeEventListener("change",__changeHandler);
         if(_awardBtn1)
         {
            _awardBtn1.removeEventListener("click",__clickBtn);
         }
         if(_awardBtn2)
         {
            _awardBtn2.removeEventListener("click",__clickBtn);
         }
         if(_awardBtn3)
         {
            _awardBtn3.removeEventListener("click",__clickBtn);
         }
         if(_awardBtn4)
         {
            _awardBtn4.removeEventListener("click",__clickBtn);
         }
         _exchangGoodsCount.removeEventListener("click",__countClickHandler);
         _exchangGoodsCount.removeEventListener("keyDown",__countOnKeyDown);
         _exchangGoodsCount.removeEventListener("change",__countChangeHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
