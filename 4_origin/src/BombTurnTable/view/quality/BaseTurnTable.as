package BombTurnTable.view.quality
{
   import BombTurnTable.TurnTableHandlerControl;
   import BombTurnTable.data.BombTurnTableGoodInfo;
   import BombTurnTable.data.BombTurnTableInfo;
   import BombTurnTable.event.TurnTableEvent;
   import BombTurnTable.view.LotteryPointer;
   import BombTurnTable.view.TurnTableGoodCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import road7th.data.DictionaryData;
   
   public class BaseTurnTable extends Sprite implements Disposeable
   {
       
      
      protected var _curLevel:int;
      
      private var _turnTableHandlerCon:TurnTableHandlerControl;
      
      protected var _bgBorder:Bitmap;
      
      protected var _bg:Bitmap;
      
      protected var _lotteryBtn:LotteryPointer;
      
      protected var _explanationTxt:FilterFrameText;
      
      protected var _lotteryTicket:FilterFrameText;
      
      protected var _turnTableCon:Sprite;
      
      protected var _goodsItem:DictionaryData;
      
      protected var _goodsData:BombTurnTableInfo;
      
      protected var _goodsPoint:Array;
      
      protected var _goodsRotation:Array;
      
      protected var _specialGoodsID:Array;
      
      protected var _selectEffPoint:Array;
      
      protected var _selectEffRotation:Array;
      
      protected var _selectMc:MovieClip;
      
      protected var _curStatus:int = 1;
      
      private var _temCell:TurnTableGoodCell;
      
      private var intervalId:uint;
      
      private var delay:Number = 1000;
      
      public function BaseTurnTable(status:int)
      {
         _goodsPoint = [new Point(38,-167),new Point(145,-91),new Point(167,37),new Point(116,143),new Point(-38,167),new Point(-145,91),new Point(-167,-37),new Point(-110,-143)];
         _goodsRotation = [22,67,112,157,-158,-113,-68,-23];
         _specialGoodsID = [-1,-2];
         _selectEffPoint = [new Point(0.9,-212),new Point(152,-150),new Point(216,4.4),new Point(147.5,156.6),new Point(-7,217),new Point(-154.8,150),new Point(-215,-1.65),new Point(-149,-150)];
         _selectEffRotation = [22,67,113,158,-157,-112,-67,-23];
         _curStatus = status;
         super();
         _goodsItem = new DictionaryData();
         _turnTableHandlerCon = new TurnTableHandlerControl(lotteryComplate_Handler);
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _turnTableCon = new Sprite();
         _turnTableCon.rotation = _turnTableCon.rotation + 22.5;
         _turnTableCon.x = 280;
         _turnTableCon.y = 283;
         _selectMc = ComponentFactory.Instance.creat("asset.bombTurnTable.selectMc");
         _selectMc.x = _selectEffPoint[0].x;
         _selectMc.y = _selectEffPoint[0].y;
         _selectMc.rotation = _selectEffRotation[0];
         addChild(_selectMc);
         _selectMc.visible = false;
         _bg = ComponentFactory.Instance.creatBitmap(bgResource);
         _bg.x = -_bg.width >> 1;
         _bg.y = -_bg.height >> 1;
         _bg.smoothing = true;
         _turnTableCon.addChild(_bg);
         _turnTableCon.addChild(_selectMc);
         addChild(_turnTableCon);
         _bgBorder = ComponentFactory.Instance.creatBitmap(bgBorResource);
         addChild(_bgBorder);
         _lotteryBtn = new LotteryPointer(this.quality,_curStatus);
         addChild(_lotteryBtn);
         PositionUtils.setPos(_lotteryBtn,"bombTurnTable.lotteryBtn.postion");
         _explanationTxt = ComponentFactory.Instance.creatComponentByStylename("bombTurnTable.explanation.textStyle");
         _explanationTxt.text = ServerConfigManager.instance.getNeedUseLotteryKicket(this.quality).toString();
         addChild(_explanationTxt);
         _lotteryTicket = ComponentFactory.Instance.creatComponentByStylename("bombTurnTable.lotteryTicket.textStyle");
         addChild(_lotteryTicket);
         updateLayout();
      }
      
      protected function updateLayout() : void
      {
      }
      
      protected function initEvent() : void
      {
         if(_lotteryBtn)
         {
            _lotteryBtn.addEventListener("ClickLottery",clickLottery_Handler);
         }
      }
      
      public function get lotteryBtn() : LotteryPointer
      {
         return _lotteryBtn;
      }
      
      protected function clickLottery_Handler(evt:TurnTableEvent) : void
      {
         SoundManager.instance.playButtonSound();
         this.dispatchEvent(new TurnTableEvent("ClickLottery",evt.data));
      }
      
      public function updateAwardGood(data:BombTurnTableInfo) : void
      {
         var info:* = null;
         var item:int = 0;
         _goodsData = data;
         if(_turnTableCon == null || _goodsData == null)
         {
            return;
         }
         var goodCount:int = _goodsData.goodsInfo.length;
         for(item = 0; item < goodCount; )
         {
            info = _goodsData.goodsInfo[item];
            _temCell = new TurnTableGoodCell(info,this.quality);
            _temCell.x = _goodsPoint[info.place - 1].x;
            _temCell.y = _goodsPoint[info.place - 1].y;
            _temCell.rotation = _goodsRotation[info.place - 1];
            if(info.templateId > 0)
            {
               _temCell.filters = info.isReceive == 1?null:ComponentFactory.Instance.creatFilters("grayFilter");
            }
            _turnTableCon.addChild(_temCell);
            _goodsItem[info.place] = _temCell;
            item++;
         }
      }
      
      public function updateLotteryTicket(value:int) : void
      {
         _lotteryTicket.text = value.toString();
      }
      
      protected function lotteryComplate_Handler(id:int) : void
      {
         var cell:* = null;
         var str:* = null;
         if(_goodsItem && _goodsItem.hasKey(id))
         {
            cell = _goodsItem[id] as TurnTableGoodCell;
            _selectMc.rotation = _selectEffRotation[id - 1];
            _selectMc.x = _selectEffPoint[id - 1].x;
            _selectMc.y = _selectEffPoint[id - 1].y;
            _selectMc.visible = true;
            _selectMc.gotoAndStop(0);
            _selectMc.play();
            if(cell.info.templateId > 0)
            {
               str = LanguageMgr.GetTranslation("ddt.bombTurnTable.winningGoodMsg",cell.getGoodName());
            }
            else if(cell.info.templateId == -1)
            {
               str = LanguageMgr.GetTranslation("ddt.bombTurnTable.turnTable.updrageMsg");
            }
            else if(cell.info.templateId == -2)
            {
               str = LanguageMgr.GetTranslation("ddt.bombTurnTable.turnTable.dedrageMsg");
            }
            MessageTipManager.getInstance().show(str);
            intervalId = setTimeout(myDelayedFunction,delay);
         }
      }
      
      public function myDelayedFunction() : void
      {
         clearTimeout(intervalId);
         this.dispatchEvent(new TurnTableEvent("lotteryComplate",null));
      }
      
      public function startLottery(id:int) : void
      {
         if(_turnTableHandlerCon && _goodsItem && _goodsItem.hasKey(id))
         {
            _turnTableHandlerCon.setData(this,id);
            _turnTableHandlerCon.startLottery();
         }
      }
      
      public function get turnTable() : Sprite
      {
         return _turnTableCon;
      }
      
      protected function get bgBorResource() : String
      {
         return "asset.bombTurnTable.white";
      }
      
      protected function get bgResource() : String
      {
         return "asset.bombTurnTable.whiteBg";
      }
      
      public function get quality() : int
      {
         return 0;
      }
      
      public function get level() : int
      {
         return _goodsData.level;
      }
      
      public function clear() : void
      {
         var count:int = 0;
         if(_turnTableCon)
         {
            count = _turnTableCon.numChildren;
            if(count > 2)
            {
               _turnTableCon.removeChildren(2,count - 1);
            }
         }
         if(_goodsItem)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _goodsItem;
            for each(var cell in _goodsItem)
            {
               ObjectUtils.disposeObject(cell);
            }
            _goodsItem.clear();
         }
      }
      
      public function dispose() : void
      {
         clear();
         _goodsItem = null;
         _temCell = null;
         _goodsData = null;
         if(_lotteryBtn)
         {
            _lotteryBtn.removeEventListener("ClickLottery",clickLottery_Handler);
            ObjectUtils.disposeObject(_lotteryBtn);
            _lotteryBtn = null;
         }
         if(_bgBorder)
         {
            ObjectUtils.disposeObject(_bgBorder);
         }
         _bgBorder = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_selectMc)
         {
            ObjectUtils.disposeObject(_selectMc);
            _selectMc = null;
         }
         if(_lotteryTicket)
         {
            ObjectUtils.disposeObject(_lotteryTicket);
         }
         _lotteryTicket = null;
         if(_explanationTxt)
         {
            ObjectUtils.disposeObject(_explanationTxt);
         }
         _explanationTxt = null;
         if(_turnTableCon)
         {
            _turnTableCon.removeChildren();
            ObjectUtils.disposeObject(_turnTableCon);
         }
         _turnTableCon = null;
         if(_turnTableHandlerCon)
         {
            _turnTableHandlerCon.stop();
         }
         _turnTableHandlerCon = null;
      }
   }
}
