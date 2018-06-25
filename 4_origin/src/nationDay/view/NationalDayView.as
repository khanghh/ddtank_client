package nationDay.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.event.ActivityEvent;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import nationDay.NationDayControl;
   import nationDay.NationDayManager;
   import nationDay.model.NationModel;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class NationalDayView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _closeBtn:SimpleBitmapButton;
      
      private var _activityTime:FilterFrameText;
      
      private var _description:FilterFrameText;
      
      private var _nationModel:NationModel;
      
      private var _haveGoodsBox1:SimpleTileList;
      
      private var _haveGoodsBox2:SimpleTileList;
      
      private var _haveGoodsBox3:SimpleTileList;
      
      private var _haveGoodsBox4:SimpleTileList;
      
      private var _haveGoodsBox:Vector.<SimpleTileList>;
      
      private var _wordVec:Vector.<NationDayWord>;
      
      private var _exchangeCellVec:Vector.<ActivitySeedCell>;
      
      private var _vBox:VBox;
      
      private var _textList:Vector.<FilterFrameText>;
      
      public function NationalDayView()
      {
         super();
         _wordVec = new Vector.<NationDayWord>();
         _exchangeCellVec = new Vector.<ActivitySeedCell>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var text:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.activity.nationalbg");
         addChild(_bg);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("nationDay.closeBtn");
         addChild(_closeBtn);
         _activityTime = ComponentFactory.Instance.creatComponentByStylename("nationDay.actTime");
         addChild(_activityTime);
         _description = ComponentFactory.Instance.creatComponentByStylename("nationDay.description");
         addChild(_description);
         _haveGoodsBox1 = ComponentFactory.Instance.creatCustomObject("nationDay.haveGoodsBox1",[4]);
         addChild(_haveGoodsBox1);
         _haveGoodsBox2 = ComponentFactory.Instance.creatCustomObject("nationDay.haveGoodsBox2",[4]);
         addChild(_haveGoodsBox2);
         _haveGoodsBox3 = ComponentFactory.Instance.creatCustomObject("nationDay.haveGoodsBox3",[4]);
         addChild(_haveGoodsBox3);
         _haveGoodsBox4 = ComponentFactory.Instance.creatCustomObject("nationDay.haveGoodsBox4",[4]);
         addChild(_haveGoodsBox4);
         _haveGoodsBox = new Vector.<SimpleTileList>();
         _haveGoodsBox.push(_haveGoodsBox1);
         _haveGoodsBox.push(_haveGoodsBox2);
         _haveGoodsBox.push(_haveGoodsBox3);
         _haveGoodsBox.push(_haveGoodsBox4);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("nationDay.limitTextVBox");
         addChild(_vBox);
         _textList = new Vector.<FilterFrameText>();
         for(i = 0; i < 4; )
         {
            text = ComponentFactory.Instance.creatComponentByStylename("nationDay.limitText");
            _vBox.addChild(text);
            _textList.push(text);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("keyDown",__onKeyDown);
         _closeBtn.addEventListener("click",__onCloseEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(288,3),__onExchangeGoods);
      }
      
      protected function __onKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 27)
         {
            SoundManager.instance.playButtonSound();
            NationDayControl.instance.hide();
         }
      }
      
      protected function __onExchangeGoods(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var flag:Boolean = pkg.readBoolean();
         var type:int = pkg.readInt();
         if(flag)
         {
            _exchangeCellVec[type].playFireworkAnimation();
            NationDayControl.instance.sendPkg();
         }
      }
      
      public function setViewInfo() : void
      {
         _nationModel = NationDayManager.instance.nationModel;
         updateTimeShow();
         updateGetTimes();
         updateDescription();
         updateHaveGoodsBox();
         updateExchangeGoodsBox();
         addAwardAnimation();
      }
      
      private function updateDescription() : void
      {
         _description.text = _nationModel.Description;
      }
      
      private function addAwardAnimation() : void
      {
         var i:int = 0;
         for(i = 0; i < _exchangeCellVec.length; )
         {
            if(_exchangeCellVec[i].getCount() > 0)
            {
               _exchangeCellVec[i].addFireworkAnimation(i);
               _exchangeCellVec[i].addEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            }
            else
            {
               _exchangeCellVec[i].removeFireworkAnimation();
               _exchangeCellVec[i].removeEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            }
            i++;
         }
      }
      
      protected function __seedGood(event:ActivityEvent) : void
      {
         SocketManager.Instance.out.exchangeNationalGoods(event.id);
      }
      
      private function updateHaveGoodsBox() : void
      {
         var j:int = 0;
         var i:int = 0;
         var cell:* = null;
         var index:int = 0;
         for(j = 0; j < NationDayManager.WordInfo.length; )
         {
            for(i = 0; i < NationDayManager.WordInfo[j].length; )
            {
               if(_haveGoodsBox[j].numChildren < 4)
               {
                  cell = new NationDayWord(NationDayManager.WordRes[j][i],NationDayManager.WordInfo[j][i],_nationModel.WordArray[NationDayManager.WordInfo[j][i]]);
                  _haveGoodsBox[j].addChild(cell);
                  _wordVec.push(cell);
               }
               else
               {
                  index++;
                  _wordVec[index].updateWordNum(_nationModel.WordArray[NationDayManager.WordInfo[j][i]]);
               }
               i++;
            }
            j++;
         }
      }
      
      private function updateExchangeGoodsBox() : void
      {
         var exchangeInfo:* = null;
         var i:int = 0;
         var exchangeCell:* = null;
         for(i = 0; i < 4; )
         {
            if(_exchangeCellVec.length < 4)
            {
               exchangeInfo = ItemManager.Instance.getTemplateById(1120449 + i);
               if(exchangeInfo)
               {
                  exchangeCell = new ActivitySeedCell(i,exchangeInfo,false);
                  exchangeCell.setCount(getExchangeNum(i));
                  exchangeCell.BGVisible = false;
                  addChild(exchangeCell);
                  _exchangeCellVec.push(exchangeCell);
                  PositionUtils.setPos(exchangeCell,"nationDay.fireworkPos" + _exchangeCellVec.length);
               }
            }
            else
            {
               _exchangeCellVec[i].setCount(getExchangeNum(i));
            }
            i++;
         }
      }
      
      private function getExchangeNum(index:int) : int
      {
         var num:int = 65535;
         var _loc5_:int = 0;
         var _loc4_:* = NationDayManager.WordInfo[index];
         for(var i in NationDayManager.WordInfo[index])
         {
            num = Math.min(num,_nationModel.WordArray[NationDayManager.WordInfo[index][i]]);
         }
         return num;
      }
      
      private function cleanExchangeCell() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _exchangeCellVec;
         for each(var cell in _exchangeCellVec)
         {
            cell.removeEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         _exchangeCellVec = new Vector.<ActivitySeedCell>();
      }
      
      private function updateTimeShow() : void
      {
         var startDate:Date = DateUtils.getDateByStr(_nationModel.StartDate);
         var endDate:Date = DateUtils.getDateByStr(_nationModel.EndDate);
         _activityTime.text = addZero(startDate.fullYear) + "." + addZero(startDate.month + 1) + "." + addZero(startDate.date);
         _activityTime.text = _activityTime.text + ("-" + addZero(endDate.fullYear) + "." + addZero(endDate.month + 1) + "." + addZero(endDate.date));
      }
      
      private function updateGetTimes() : void
      {
         var i:int = 0;
         var times:int = 0;
         var maxTimes:* = null;
         for(i = 0; i < 4; )
         {
            times = _nationModel.getTimes[i];
            maxTimes = _nationModel.maxTimes[i];
            _textList[i].text = LanguageMgr.GetTranslation("godCardRaiseExchangeRightCard.countTxtMsg",times,maxTimes);
            i++;
         }
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
      
      private function __onCloseEventHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         NationDayControl.instance.hide();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         cleanExchangeCell();
         if(_activityTime)
         {
            _activityTime.dispose();
            _activityTime = null;
         }
         if(_description)
         {
            _description.dispose();
            _description = null;
         }
         if(_closeBtn)
         {
            _closeBtn.dispose();
            _closeBtn = null;
         }
         i = 0;
         while(i < _haveGoodsBox.length)
         {
            _haveGoodsBox[i].dispose();
            _haveGoodsBox[i] = null;
            i++;
         }
         _haveGoodsBox.length = 0;
         _haveGoodsBox = null;
         _textList.length = 0;
         _textList = null;
         _nationModel = null;
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("keyDown",__onKeyDown);
         _closeBtn.removeEventListener("click",__onCloseEventHandler);
         SocketManager.Instance.removeEventListener(PkgEvent.format(288,3),__onExchangeGoods);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,2,true,1);
      }
   }
}
