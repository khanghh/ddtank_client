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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("nationDay.limitText");
            _vBox.addChild(_loc1_);
            _textList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("keyDown",__onKeyDown);
         _closeBtn.addEventListener("click",__onCloseEventHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(288,3),__onExchangeGoods);
      }
      
      protected function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 27)
         {
            SoundManager.instance.playButtonSound();
            NationDayControl.instance.hide();
         }
      }
      
      protected function __onExchangeGoods(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc3_.readBoolean();
         var _loc4_:int = _loc3_.readInt();
         if(_loc2_)
         {
            _exchangeCellVec[_loc4_].playFireworkAnimation();
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
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _exchangeCellVec.length)
         {
            if(_exchangeCellVec[_loc1_].getCount() > 0)
            {
               _exchangeCellVec[_loc1_].addFireworkAnimation(_loc1_);
               _exchangeCellVec[_loc1_].addEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            }
            else
            {
               _exchangeCellVec[_loc1_].removeFireworkAnimation();
               _exchangeCellVec[_loc1_].removeEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            }
            _loc1_++;
         }
      }
      
      protected function __seedGood(param1:ActivityEvent) : void
      {
         SocketManager.Instance.out.exchangeNationalGoods(param1.id);
      }
      
      private function updateHaveGoodsBox() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < NationDayManager.WordInfo.length)
         {
            _loc4_ = 0;
            while(_loc4_ < NationDayManager.WordInfo[_loc3_].length)
            {
               if(_haveGoodsBox[_loc3_].numChildren < 4)
               {
                  _loc2_ = new NationDayWord(NationDayManager.WordRes[_loc3_][_loc4_],NationDayManager.WordInfo[_loc3_][_loc4_],_nationModel.WordArray[NationDayManager.WordInfo[_loc3_][_loc4_]]);
                  _haveGoodsBox[_loc3_].addChild(_loc2_);
                  _wordVec.push(_loc2_);
               }
               else
               {
                  _loc1_++;
                  _wordVec[_loc1_].updateWordNum(_nationModel.WordArray[NationDayManager.WordInfo[_loc3_][_loc4_]]);
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function updateExchangeGoodsBox() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(_exchangeCellVec.length < 4)
            {
               _loc2_ = ItemManager.Instance.getTemplateById(1120449 + _loc3_);
               if(_loc2_)
               {
                  _loc1_ = new ActivitySeedCell(_loc3_,_loc2_,false);
                  _loc1_.setCount(getExchangeNum(_loc3_));
                  _loc1_.BGVisible = false;
                  addChild(_loc1_);
                  _exchangeCellVec.push(_loc1_);
                  PositionUtils.setPos(_loc1_,"nationDay.fireworkPos" + _exchangeCellVec.length);
               }
            }
            else
            {
               _exchangeCellVec[_loc3_].setCount(getExchangeNum(_loc3_));
            }
            _loc3_++;
         }
      }
      
      private function getExchangeNum(param1:int) : int
      {
         var _loc2_:int = 65535;
         var _loc5_:int = 0;
         var _loc4_:* = NationDayManager.WordInfo[param1];
         for(var _loc3_ in NationDayManager.WordInfo[param1])
         {
            _loc2_ = Math.min(_loc2_,_nationModel.WordArray[NationDayManager.WordInfo[param1][_loc3_]]);
         }
         return _loc2_;
      }
      
      private function cleanExchangeCell() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _exchangeCellVec;
         for each(var _loc1_ in _exchangeCellVec)
         {
            _loc1_.removeEventListener(ActivityEvent.SEND_GOOD,__seedGood);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _exchangeCellVec = new Vector.<ActivitySeedCell>();
      }
      
      private function updateTimeShow() : void
      {
         var _loc1_:Date = DateUtils.getDateByStr(_nationModel.StartDate);
         var _loc2_:Date = DateUtils.getDateByStr(_nationModel.EndDate);
         _activityTime.text = addZero(_loc1_.fullYear) + "." + addZero(_loc1_.month + 1) + "." + addZero(_loc1_.date);
         _activityTime.text = _activityTime.text + ("-" + addZero(_loc2_.fullYear) + "." + addZero(_loc2_.month + 1) + "." + addZero(_loc2_.date));
      }
      
      private function updateGetTimes() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = _nationModel.getTimes[_loc3_];
            _loc2_ = _nationModel.maxTimes[_loc3_];
            _textList[_loc3_].text = LanguageMgr.GetTranslation("godCardRaiseExchangeRightCard.countTxtMsg",_loc1_,_loc2_);
            _loc3_++;
         }
      }
      
      private function addZero(param1:Number) : String
      {
         var _loc2_:* = null;
         if(param1 < 10)
         {
            _loc2_ = "0" + param1.toString();
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      private function __onCloseEventHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         NationDayControl.instance.hide();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _haveGoodsBox.length)
         {
            _haveGoodsBox[_loc1_].dispose();
            _haveGoodsBox[_loc1_] = null;
            _loc1_++;
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
