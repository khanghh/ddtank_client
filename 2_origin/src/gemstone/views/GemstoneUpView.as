package gemstone.views
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.PersonalInfoCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.FTextButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import gemstone.GemstoneManager;
   import gemstone.info.GemstListInfo;
   import gemstone.info.GemstnoeSendInfo;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.info.GemstoneUpGradeInfo;
   import gemstone.items.ExpBar;
   import gemstone.items.GemstoneBuyItem;
   import gemstone.items.GemstoneContent;
   import org.aswing.KeyboardManager;
   
   public class GemstoneUpView extends Frame
   {
      
      private static const ANGLE_P:int = 120;
      
      private static const FIG_POS:int = 2;
       
      
      private var baseMc:MovieClip;
      
      private var _contArray:Vector.<GemstoneContent>;
      
      private var _centerP:Point;
      
      private var _angle:int = 0;
      
      private var _upgradeBtn:SimpleBitmapButton;
      
      private var _upghostBtn:SimpleBitmapButton;
      
      private var _cellPos:Array;
      
      private var _cells:Vector.<PersonalInfoCell>;
      
      private var _cellContent:Sprite;
      
      private var _selfInfo:SelfInfo;
      
      private var _radius:Number = 100;
      
      private var _contArrlen:int;
      
      private var _expBar:ExpBar;
      
      private var _hairBtn:FTextButton;
      
      private var _faceBtn:FTextButton;
      
      private var _eyeBtn:FTextButton;
      
      private var _suitBtn:FTextButton;
      
      private var _decorateBtn:FTextButton;
      
      private var _selectBtn:SelectedButton;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _selectTxt:FilterFrameText;
      
      private var _mouseClick:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _gemstoneCriView:GemstoneCriView;
      
      private var _isAutoSele:int;
      
      private var _dataList:Vector.<InventoryItemInfo>;
      
      private var _sendInfo:GemstnoeSendInfo;
      
      private var _equipPlayce:int = 2;
      
      private var _fightSpiritId:int;
      
      private var statiDataList:Vector.<GemstoneStaticInfo>;
      
      private var _gemstoneInfoView:GemstoneInfoView;
      
      public var curIndex:int;
      
      private var _bagitem:BagCell;
      
      private var _seletedBitMap:Bitmap;
      
      private var buyItem:GemstoneBuyItem;
      
      private var _btnContent:Sprite;
      
      public function GemstoneUpView(_info:SelfInfo)
      {
         _dataList = new Vector.<InventoryItemInfo>();
         _selfInfo = _info;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _expBar = ComponentFactory.Instance.creatComponentByStylename("expBar");
         addChild(_expBar);
         if(GemstoneManager.Instance.hariList.length > 0)
         {
            _fightSpiritId = GemstoneManager.Instance.hariList[0].fightSpiritId;
         }
         _gemstoneInfoView = new GemstoneInfoView();
         _gemstoneInfoView.x = 376;
         _gemstoneInfoView.y = 15;
         addChild(_gemstoneInfoView);
         var info:InventoryItemInfo = _selfInfo == null?null:_selfInfo.Bag.getItemAt(2);
         _gemstoneCriView = new GemstoneCriView();
         _gemstoneCriView.x = 232;
         _gemstoneCriView.y = 209;
         _gemstoneCriView.staticDataList = GemstoneManager.Instance.redInfoList;
         _gemstoneCriView.upDataIcon(info);
         _gemstoneCriView.initFigSkin("gemstone.attckBig");
         addChild(_gemstoneCriView);
         _gemstoneCriView.resetGemstoneList(GemstoneManager.Instance.hariList);
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("upgradeButton");
         _upghostBtn = ComponentFactory.Instance.creatComponentByStylename("upghostButton");
         _btnContent = new Sprite();
         _btnContent.x = 0;
         _btnContent.y = 1;
         addChild(_btnContent);
         _hairBtn = new FTextButton("gemstone.yellow","gemstoneBtnTxt");
         _hairBtn.x = 25;
         _hairBtn.y = 29;
         _hairBtn.setTxt(LanguageMgr.GetTranslation("ddt.gemstone.upview.hair"));
         _hairBtn.id = 1;
         _hairBtn.addEventListener("click",btnClickHander);
         _faceBtn = new FTextButton("gemstone.yellow","gemstoneBtnTxt");
         _faceBtn.x = 87;
         _faceBtn.y = 29;
         _faceBtn.setTxt(LanguageMgr.GetTranslation("ddt.gemstone.upview.face"));
         _faceBtn.id = 2;
         _faceBtn.addEventListener("click",btnClickHander);
         _eyeBtn = new FTextButton("gemstone.yellow","gemstoneBtnTxt");
         _eyeBtn.x = 147;
         _eyeBtn.y = 29;
         _eyeBtn.setTxt(LanguageMgr.GetTranslation("ddt.gemstone.upview.eye"));
         _eyeBtn.id = 3;
         _eyeBtn.addEventListener("click",btnClickHander);
         _suitBtn = new FTextButton("gemstone.yellow2","gemstoneBtnTxt2");
         _suitBtn.x = 208;
         _suitBtn.y = 29;
         _suitBtn.setTxt(LanguageMgr.GetTranslation("ddt.gemstone.upview.suit"));
         _suitBtn.id = 4;
         _suitBtn.addEventListener("click",btnClickHander);
         _decorateBtn = new FTextButton("gemstone.yellow","gemstoneBtnTxt");
         _decorateBtn.x = 288;
         _decorateBtn.y = 29;
         _decorateBtn.setTxt(LanguageMgr.GetTranslation("ddt.gemstone.upview.decorate"));
         _decorateBtn.id = 5;
         _decorateBtn.addEventListener("click",btnClickHander);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("zhanhunDescript");
         _txt1.text = LanguageMgr.GetTranslation("ddt.gemstone.upview.txt1");
         _txt1.x = 26;
         _txt1.y = 330;
         addChild(_txt1);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("writhTxt");
         _txt2.text = LanguageMgr.GetTranslation("ddt.gemstone.upview.txt2");
         _txt2.x = 172;
         _txt2.y = 330;
         addChild(_txt2);
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("zhanhunDescript");
         _txt4.x = 30;
         _txt4.y = 333;
         _txt4.text = LanguageMgr.GetTranslation("ddt.gemstone.upview.txt4");
         addChild(_txt4);
         _selectTxt = ComponentFactory.Instance.creatComponentByStylename("selectUpGrade");
         _selectTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.upview.txt5");
         addChild(_selectTxt);
         _mouseClick = ComponentFactory.Instance.creatComponentByStylename("mouseClick");
         _mouseClick.text = LanguageMgr.GetTranslation("ddt.gemstone.upview.txt6");
         addChild(_mouseClick);
         _upgradeBtn.addEventListener("click",mouseClickHander);
         _upghostBtn.addEventListener("click",mouseClickHander);
         _btnContent.addChild(_hairBtn);
         _btnContent.addChild(_faceBtn);
         _btnContent.addChild(_eyeBtn);
         _btnContent.addChild(_suitBtn);
         _btnContent.addChild(_decorateBtn);
         addChild(_upgradeBtn);
         _selectBtn = ComponentFactory.Instance.creatComponentByStylename("gemstone.selectedBtn");
         _selectBtn.addEventListener("click",selectHander);
         addChild(_selectBtn);
         visibleGroup1(false);
         visibleGroup2(true);
         var bg:Sprite = new Sprite();
         var stoneInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(100100);
         _bagitem = new BagCell(0,stoneInfo);
         _bagitem.x = 32;
         _bagitem.y = 280;
         addChild(_bagitem);
         upDatafitCount();
         buyItem = new GemstoneBuyItem();
         buyItem.x = 82;
         buyItem.y = 310;
         buyItem.setup(100100,5);
         addChild(buyItem);
         buyItem.visible = false;
         _seletedBitMap = ComponentFactory.Instance.creatBitmap("gemstone.seleted");
         _seletedBitMap.x = _hairBtn.x - 2;
         _seletedBitMap.y = _hairBtn.y - 2;
         _btnContent.addChild(_seletedBitMap);
      }
      
      protected function updateCount(event:BagEvent) : void
      {
         upDatafitCount();
      }
      
      public function upDatafitCount() : void
      {
         if(!_bagitem)
         {
            return;
         }
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var conut:int = bagInfo.getItemCountByTemplateId(100100);
         conut = conut + bagInfo.getItemCountByTemplateId(201264);
         _bagitem.setCount(conut);
      }
      
      private function visibleGroup1(bool:Boolean) : void
      {
         _mouseClick.visible = bool;
         _selectTxt.visible = bool;
         _gemstoneInfoView.visible = bool;
      }
      
      private function visibleGroup2(bool:Boolean) : void
      {
         _txt1.visible = bool;
         _txt2.visible = bool;
         _txt4.visible = bool;
         _expBar.visible = bool;
         _selectBtn.visible = bool;
         _gemstoneInfoView.visible = bool;
      }
      
      public function get expBar() : ExpBar
      {
         return _expBar;
      }
      
      protected function selectHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectBtn.selected)
         {
            _isAutoSele = 1;
         }
         else
         {
            _isAutoSele = 0;
         }
      }
      
      protected function btnClickHander(event:MouseEvent) : void
      {
         var info:* = null;
         var data:* = null;
         var gemstoneList:* = undefined;
         var place:int = 0;
         var str:* = null;
         SoundManager.instance.play("008");
         visibleGroup1(false);
         visibleGroup2(true);
         if(event.currentTarget.id == 1)
         {
            info = _selfInfo == null?null:_selfInfo.Bag.getItemAt(2);
            if(GemstoneManager.Instance.hariList.length > 0)
            {
               gemstoneList = GemstoneManager.Instance.hariList;
               _fightSpiritId = GemstoneManager.Instance.hariList[0].fightSpiritId;
            }
            _equipPlayce = 2;
            str = "gemstone.attckBig";
            GemstoneManager.Instance.curstatiDataList = GemstoneManager.Instance.redInfoList;
         }
         else if(event.currentTarget.id == 2)
         {
            info = _selfInfo == null?null:_selfInfo.Bag.getItemAt(3);
            if(GemstoneManager.Instance.faceList.length > 0)
            {
               gemstoneList = GemstoneManager.Instance.faceList;
               _fightSpiritId = GemstoneManager.Instance.faceList[0].fightSpiritId;
            }
            _equipPlayce = 3;
            str = "gemstone.luckyBig";
            GemstoneManager.Instance.curstatiDataList = GemstoneManager.Instance.yelInfoList;
         }
         else if(event.currentTarget.id == 3)
         {
            info = _selfInfo == null?null:_selfInfo.Bag.getItemAt(5);
            if(GemstoneManager.Instance.glassList.length > 0)
            {
               gemstoneList = GemstoneManager.Instance.glassList;
               _fightSpiritId = GemstoneManager.Instance.glassList[0].fightSpiritId;
            }
            _equipPlayce = 5;
            str = "gemstone.agileBig";
            GemstoneManager.Instance.curstatiDataList = GemstoneManager.Instance.greInfoList;
         }
         else if(event.currentTarget.id == 4)
         {
            info = _selfInfo == null?null:_selfInfo.Bag.getItemAt(11);
            if(GemstoneManager.Instance.suitList.length > 0)
            {
               gemstoneList = GemstoneManager.Instance.suitList;
               _fightSpiritId = GemstoneManager.Instance.suitList[0].fightSpiritId;
            }
            _equipPlayce = 11;
            str = "gemstone.defenseBig";
            GemstoneManager.Instance.curstatiDataList = GemstoneManager.Instance.bluInfoList;
         }
         else if(event.currentTarget.id == 5)
         {
            info = _selfInfo == null?null:_selfInfo.Bag.getItemAt(13);
            if(GemstoneManager.Instance.decorationList.length > 0)
            {
               gemstoneList = GemstoneManager.Instance.decorationList;
               _fightSpiritId = GemstoneManager.Instance.decorationList[0].fightSpiritId;
            }
            _equipPlayce = 13;
            str = "gemstone.hpBig";
            GemstoneManager.Instance.curstatiDataList = GemstoneManager.Instance.purpleInfoList;
         }
         _gemstoneCriView.place = _equipPlayce;
         _gemstoneCriView.staticDataList = GemstoneManager.Instance.curstatiDataList;
         _gemstoneCriView.initFigSkin(str);
         _gemstoneCriView.upDataIcon(info);
         if(gemstoneList)
         {
            _gemstoneCriView.resetGemstoneList(gemstoneList);
         }
         _seletedBitMap.x = event.currentTarget.x - 2;
         _seletedBitMap.y = event.currentTarget.y - 2;
         _seletedBitMap.width = event.currentTarget.width + 3;
         updateContentBG();
         updateUpButton(gemstoneList);
      }
      
      public function updateContentBG() : void
      {
         _gemstoneCriView.updateContentBG();
      }
      
      public function updateUpButton(list:Vector.<GemstListInfo>) : void
      {
         var isgolden:Boolean = true;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var info in list)
         {
            if(info.level < 6 - 1)
            {
               isgolden = false;
               break;
            }
         }
         if(isgolden)
         {
            _upgradeBtn.parent && removeChild(_upgradeBtn);
            addChild(_upghostBtn);
         }
         else
         {
            _upghostBtn.parent && removeChild(_upghostBtn);
            addChild(_upgradeBtn);
         }
      }
      
      private function mouseClickHander(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var goodsId:int = 10010001;
         var templeteId:int = 201264;
         var bagInfo:BagInfo = _selfInfo.getBag(1);
         var infoCount:int = bagInfo.getItemCountByTemplateId(templeteId);
         if(infoCount > 0)
         {
            sendFigSpiritUpGrade(goodsId,templeteId);
         }
         else
         {
            goodsId = 10010001;
            templeteId = 100100;
            infoCount = infoCount + bagInfo.getItemCountByTemplateId(templeteId);
            if(infoCount > 0)
            {
               sendFigSpiritUpGrade(goodsId,templeteId);
            }
         }
      }
      
      private function sendFigSpiritUpGrade($goodsId:int, $templeteId:int) : void
      {
         GemstoneManager.Instance.gemstoneFrame.getMaskMc().visible = true;
         KeyboardManager.getInstance().isStopDispatching = true;
         SoundManager.instance.play("170");
         var sendInfo:GemstnoeSendInfo = new GemstnoeSendInfo();
         sendInfo.autoBuyId = _isAutoSele;
         sendInfo.goodsId = $goodsId;
         sendInfo.type = 1;
         sendInfo.templeteId = $templeteId;
         sendInfo.fightSpiritId = _fightSpiritId;
         sendInfo.equipPlayce = _equipPlayce;
         sendInfo.place = 2;
         sendInfo.count = 1;
         SocketManager.Instance.out.figSpiritUpGrade(sendInfo);
      }
      
      public function gemstoneAction(info:GemstoneUpGradeInfo) : void
      {
         _gemstoneCriView.upGradeAction(info);
      }
      
      public function upDataCur(obj:Object) : void
      {
      }
      
      override public function dispose() : void
      {
         _gemstoneCriView.dispose();
         PlayerManager.Instance.removeEventListener("gemstone_buy_count",updateCount);
         _upgradeBtn.removeEventListener("click",mouseClickHander);
         _upghostBtn.removeEventListener("click",mouseClickHander);
         _decorateBtn.removeEventListener("click",btnClickHander);
         _hairBtn.removeEventListener("click",btnClickHander);
         _faceBtn.removeEventListener("click",btnClickHander);
         _eyeBtn.removeEventListener("click",btnClickHander);
         _suitBtn.removeEventListener("click",btnClickHander);
         _selectBtn.removeEventListener("click",selectHander);
         if(_upgradeBtn)
         {
            ObjectUtils.disposeObject(_upgradeBtn);
         }
         _upgradeBtn = null;
         if(_upghostBtn)
         {
            ObjectUtils.disposeObject(_upghostBtn);
         }
         _upghostBtn = null;
         if(_decorateBtn)
         {
            ObjectUtils.disposeObject(_decorateBtn);
         }
         _decorateBtn = null;
         if(_hairBtn)
         {
            ObjectUtils.disposeObject(_hairBtn);
         }
         _hairBtn = null;
         if(_faceBtn)
         {
            ObjectUtils.disposeObject(_faceBtn);
         }
         _faceBtn = null;
         if(_eyeBtn)
         {
            ObjectUtils.disposeObject(_eyeBtn);
         }
         _eyeBtn = null;
         if(_suitBtn)
         {
            ObjectUtils.disposeObject(_suitBtn);
         }
         _suitBtn = null;
         if(_selectBtn)
         {
            ObjectUtils.disposeObject(_selectBtn);
         }
         _selectBtn = null;
         if(_gemstoneCriView)
         {
            ObjectUtils.disposeObject(_gemstoneCriView);
         }
         _gemstoneCriView = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_txt1)
         {
            ObjectUtils.disposeObject(_txt1);
         }
         _txt1 = null;
         if(_txt2)
         {
            ObjectUtils.disposeObject(_txt2);
         }
         _txt2 = null;
         if(_txt3)
         {
            ObjectUtils.disposeObject(_txt3);
         }
         _txt3 = null;
         if(_txt4)
         {
            ObjectUtils.disposeObject(_txt4);
         }
         _txt4 = null;
         if(_expBar)
         {
            ObjectUtils.disposeObject(_expBar);
         }
         _expBar = null;
         if(_seletedBitMap)
         {
            ObjectUtils.disposeObject(_seletedBitMap);
         }
         _seletedBitMap = null;
      }
   }
}
