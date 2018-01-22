package farm.viewx
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.SceneCharacterEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import ddt.view.sceneCharacter.SceneCharacterPlayerBase;
   import ddt.view.scenePathSearcher.PathMapHitTester;
   import ddt.view.scenePathSearcher.SceneScene;
   import farm.FarmEvent;
   import farm.FarmModelController;
   import farm.modelx.FieldVO;
   import farm.player.FarmPlayer;
   import farm.player.vo.PlayerVO;
   import farm.view.compose.event.SelectComposeItemEvent;
   import farm.viewx.helper.FarmHelperView;
   import farm.viewx.poultry.FarmPoultry;
   import farm.viewx.poultry.FarmTree;
   import farm.viewx.shop.FarmShopView;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import petsBag.PetsBagManager;
   import petsBag.event.UpdatePetFarmGuildeEvent;
   import road7th.comm.PackageIn;
   import toyMachine.ToyMachineManager;
   import trainer.view.NewHandContainer;
   import treasure.controller.TreasureManager;
   
   public class FarmMainView extends Sprite implements Disposeable
   {
       
      
      private var _bgSprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _water:MovieClip;
      
      private var _water1:MovieClip;
      
      private var _waterwheel:MovieClip;
      
      private var _float:MovieClip;
      
      private var _pastureHouseBtn:MovieClip;
      
      private var _friendListView:FarmFriendListView;
      
      private var _farmHelperBtn:BaseButton;
      
      private var _farmShopBtn:BaseButton;
      
      private var _doSeedBtn:BaseButton;
      
      private var _doMatureBtn:BaseButton;
      
      private var _goHomeBtn:BaseButton;
      
      private var _goTreasureBtn:SimpleButton;
      
      private var _arrangeBtn:BaseButton;
      
      private var _buyExpBtn:SimpleBitmapButton;
      
      private var _farmShovelBtn:FarmKillCropCell;
      
      private var _fireflyMC1:MovieClip;
      
      private var _fireflyMC2:MovieClip;
      
      private var _fireflyMC3:MovieClip;
      
      private var _startHelperMC:MovieClip;
      
      private var _fieldView:FarmFieldsView;
      
      private var _hostNameBmp:Bitmap;
      
      private var _farmName:FilterFrameText;
      
      private var _newPetPao:Bitmap;
      
      private var _newdragon:Bitmap;
      
      private var _newPetText:FilterFrameText;
      
      private var _buyExpText:FilterFrameText;
      
      private var _buyExpEffect:MovieImage;
      
      private var _selfPlayer:FarmPlayer;
      
      private var _friendPlayer:FarmPlayer;
      
      private var _currentLoadingPlayer:FarmPlayer;
      
      private var _lastClick:Number = 0;
      
      private var _clickInterval:Number = 200;
      
      private var _mouseMovie:MovieClip;
      
      private var _sceneScene:SceneScene;
      
      private var _meshLayer:Sprite;
      
      private var _needMoney:int;
      
      private var _farmTree:FarmTree;
      
      private var _farmPoultry:FarmPoultry;
      
      private var _farmBuyExpFrame:FarmBuyExpFrame;
      
      private var _selectedView:ManureOrSeedSelectedView;
      
      private var _farmHelper:FarmHelperView;
      
      private var _farmShop:FarmShopView;
      
      private var _currentFarmHelperFrame:int;
      
      public function FarmMainView()
      {
         super();
         init();
         initEvent();
         __enterFram(null);
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.farm.mainViewBg");
         _bgSprite = new Sprite();
         _bgSprite.addChild(_bg);
         this.addChild(_bgSprite);
         _water = ClassUtils.CreatInstance("asset.farm.water");
         PositionUtils.setPos(_water,"farm.waterPos");
         _water1 = ClassUtils.CreatInstance("asset.farm.water1");
         PositionUtils.setPos(_water1,"farm.waterPos1");
         _waterwheel = ClassUtils.CreatInstance("asset.farm.waterwheel");
         PositionUtils.setPos(_waterwheel,"farm.waterwheelPos");
         _float = ClassUtils.CreatInstance("asset.farm.float");
         PositionUtils.setPos(_float,"farm.floatPos");
         _fireflyMC1 = ClassUtils.CreatInstance("asset.farm.fireflyAsset");
         PositionUtils.setPos(_fireflyMC1,"farm.fireflyPos1");
         _fireflyMC2 = ClassUtils.CreatInstance("asset.farm.fireflyAsset");
         PositionUtils.setPos(_fireflyMC2,"farm.fireflyPos2");
         _fireflyMC3 = ClassUtils.CreatInstance("asset.farm.fireflyAsset");
         PositionUtils.setPos(_fireflyMC3,"farm.fireflyPos3");
         var _loc1_:* = false;
         _water1.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _water1.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC3.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC3.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC2.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC2.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC1.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _fireflyMC1.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _float.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _float.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _waterwheel.mouseChildren = _loc1_;
         _loc1_ = _loc1_;
         _waterwheel.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _water.mouseChildren = _loc1_;
         _water.mouseEnabled = _loc1_;
         addChild(_water);
         addChild(_water1);
         addChild(_waterwheel);
         addChild(_float);
         addChild(_fireflyMC1);
         addChild(_fireflyMC2);
         addChild(_fireflyMC3);
         _meshLayer = ComponentFactory.Instance.creat("asset.farm.zone") as Sprite;
         _meshLayer.alpha = 0;
         addChild(_meshLayer);
         _fieldView = new FarmFieldsView();
         PositionUtils.setPos(_fieldView,"farm.fieldsView");
         addChild(_fieldView);
         initToolBtn();
         _hostNameBmp = ComponentFactory.Instance.creatBitmap("asset.farm.fieldHostName");
         _hostNameBmp.x = (StageReferance.stageWidth - _hostNameBmp.width) / 2;
         addChild(_hostNameBmp);
         _farmName = ComponentFactory.Instance.creatComponentByStylename("farm.mainView.hostName");
         addChild(_farmName);
         _farmName.text = FarmModelController.instance.model.currentFarmerName;
         petFarmGuilde();
         _startHelperMC = ClassUtils.CreatInstance("assets.farm.startHelper.mc") as MovieClip;
         _startHelperMC.visible = false;
         PositionUtils.setPos(_startHelperMC,"farm.helper.startHelper.mc.Pos");
         addChild(_startHelperMC);
         checkHelper();
         if(FarmModelController.instance.midAutumnFlag)
         {
            addSelfPlayer();
         }
         _farmTree = new FarmTree();
         PositionUtils.setPos(_farmTree,"asset.farm.treePos");
         addChild(_farmTree);
         _farmPoultry = new FarmPoultry();
         _farmPoultry.addEventListener("complete",__onComplete);
         _farmPoultry.startLoadPoultry();
         PositionUtils.setPos(_farmPoultry,"asset.farm.poultryPos");
         addChild(_farmPoultry);
         _pastureHouseBtn = ClassUtils.CreatInstance("asset.farm.pastureBtn");
         PositionUtils.setPos(_pastureHouseBtn,"farm.pasturehousebtnPos");
         addChild(_pastureHouseBtn);
         _friendListView = new FarmFriendListView();
         PositionUtils.setPos(_friendListView,"farm.friendListViewPos");
         addChild(_friendListView);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(135))
         {
            if(PlayerManager.Instance.Self.Grade >= 19)
            {
               NewHandContainer.Instance.showArrow(146,45,new Point(860,103),"","",this);
            }
         }
      }
      
      protected function __onComplete(param1:Event) : void
      {
         _farmPoultry.removeEventListener("complete",__onComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(81,21),__onGetPoultryLevel);
         SocketManager.Instance.out.getFarmPoultryLevel(FarmModelController.instance.model.currentFarmerId);
      }
      
      protected function __onGetPoultryLevel(param1:PkgEvent) : void
      {
         var _loc7_:PackageIn = param1.pkg;
         var _loc5_:int = _loc7_.readInt();
         var _loc3_:int = _loc7_.readInt();
         var _loc4_:int = _loc7_.readInt();
         var _loc8_:int = _loc7_.readInt();
         var _loc6_:int = _loc7_.readByte();
         var _loc2_:Date = _loc7_.readDate();
         if(_loc5_ == FarmModelController.instance.model.currentFarmerId)
         {
            _farmTree.setLevel(_loc3_);
            _farmPoultry.setInfo(_loc4_,_loc8_,_loc6_,_loc2_);
         }
      }
      
      public function addSelfPlayer() : void
      {
         var _loc1_:* = null;
         var _loc2_:Class = ClassUtils.uiSourceDomain.getDefinition("asset.farm.MouseClickMovie") as Class;
         _mouseMovie = new _loc2_() as MovieClip;
         _mouseMovie.mouseChildren = false;
         _mouseMovie.mouseEnabled = false;
         _mouseMovie.stop();
         addChild(_mouseMovie);
         _sceneScene = new SceneScene();
         _sceneScene.setHitTester(new PathMapHitTester(_meshLayer));
         if(!_selfPlayer)
         {
            _loc1_ = new PlayerVO();
            _loc1_.playerInfo = PlayerManager.Instance.Self;
            _currentLoadingPlayer = new FarmPlayer(_loc1_,addPlayerCallBack);
         }
      }
      
      private function addPlayerCallBack(param1:FarmPlayer, param2:Boolean, param3:int) : void
      {
         if(param3 == 0)
         {
            if(!param1)
            {
               return;
            }
            _currentLoadingPlayer = null;
            param1.sceneScene = _sceneScene;
            var _loc4_:* = param1.playerVO.scenePlayerDirection;
            param1.sceneCharacterDirection = _loc4_;
            param1.setSceneCharacterDirectionDefault = _loc4_;
            if(!_selfPlayer && param1.playerVO.playerInfo.ID == PlayerManager.Instance.Self.ID)
            {
               _selfPlayer = param1;
               addChild(_selfPlayer);
               _selfPlayer.addEventListener("characterActionChange",playerActionChange);
            }
            else
            {
               _friendPlayer = param1;
               addChild(param1);
            }
            param1.playerPoint = new Point(200,300);
            param1.sceneCharacterStateType = "natural";
            addEventListener("enterFrame",__updateFrame);
         }
      }
      
      protected function playerActionChange(param1:SceneCharacterEvent) : void
      {
         var _loc2_:String = param1.data.toString();
         if(_loc2_ == "naturalStandFront" || _loc2_ == "naturalStandBack")
         {
            _mouseMovie.gotoAndStop(1);
         }
      }
      
      protected function __onPlayerClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(_selfPlayer)
         {
            _loc2_ = this.globalToLocal(new Point(param1.stageX,param1.stageY));
            if(getTimer() - _lastClick > _clickInterval)
            {
               _lastClick = getTimer();
               if(!_sceneScene.hit(_loc2_))
               {
                  _mouseMovie.x = _loc2_.x;
                  _mouseMovie.y = _loc2_.y;
                  _mouseMovie.play();
                  _selfPlayer.playerVO.walkPath = _sceneScene.searchPath(_selfPlayer.playerPoint,_loc2_);
                  _selfPlayer.playerVO.walkPath.shift();
                  _selfPlayer.playerVO.scenePlayerDirection = SceneCharacterDirection.getDirection(_selfPlayer.playerPoint,_selfPlayer.playerVO.walkPath[0]);
                  _selfPlayer.playerVO.currentWalkStartPoint = _selfPlayer.currentWalkStartPoint;
               }
            }
         }
      }
      
      protected function __updateFrame(param1:Event) : void
      {
         if(_selfPlayer)
         {
            _selfPlayer.updatePlayer();
         }
         if(_friendPlayer)
         {
            _friendPlayer.updatePlayer();
         }
      }
      
      private function dargonPetShow() : void
      {
         _newPetPao = ComponentFactory.Instance.creatBitmap("assets.farm.newPetPao");
         addChild(_newPetPao);
         _newdragon = ComponentFactory.Instance.creatBitmap("assets.farm.newdragon");
         addChild(_newdragon);
         _newPetText = ComponentFactory.Instance.creatComponentByStylename("confirmHelperMoneyAlertFrame.newPetComesTxt");
         _newPetText.htmlText = LanguageMgr.GetTranslation("ddt.farms.newPetsComew");
         addChild(_newPetText);
      }
      
      private function set newPetShowVisble(param1:Boolean) : void
      {
         _newPetPao.visible = param1;
         _newdragon.visible = param1;
         _newPetText.visible = param1;
      }
      
      private function checkHelper() : void
      {
         if(PlayerManager.Instance.Self.isFarmHelper && PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
         {
            _fieldView.setFieldByHelper();
            setVisibleByAuto(false);
            if(_farmHelper == null)
            {
               _farmHelper = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperView.helper");
               _farmHelper.show();
            }
         }
      }
      
      private function setVisibleByAuto(param1:Boolean = true) : void
      {
         if(_doSeedBtn)
         {
            _doSeedBtn.enable = param1;
         }
         if(_doMatureBtn)
         {
            _doMatureBtn.enable = param1;
         }
         if(_farmShovelBtn)
         {
            _farmShovelBtn.setBtnVis(param1);
         }
         if(_startHelperMC)
         {
            _startHelperMC.visible = !param1;
         }
      }
      
      private function __setVisible(param1:FarmEvent) : void
      {
         setVisibleByAuto(false);
      }
      
      private function __setVisibleFal(param1:FarmEvent) : void
      {
         setVisibleByAuto(true);
      }
      
      private function petFarmGuilde() : void
      {
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            PetsBagManager.instance().showPetFarmGuildArrow(91,-150,"farmTrainer.openAdoptPetArrowPos","asset.farmTrainer.clickHere","farmTrainer.openAdoptPetTipPos",this);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(369))
         {
            PetsBagManager.instance().showPetFarmGuildArrow(101,-60,"farmTrainer.seedArrowPos","asset.farmTrainer.seed","farmTrainer.seedTipPos",this);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(119);
            PetsBagManager.instance().showPetFarmGuildArrow(107,-50,"farmTrainer.grainArrowPos","asset.farmTrainer.grain2","farmTrainer.grainFieldTipPos",this);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(366) && SharedManager.Instance.stoneFriend)
         {
            SharedManager.Instance.stoneFriend = false;
            SharedManager.Instance.save();
            PetsBagManager.instance().showPetFarmGuildArrow(114,-150,"farmTrainer.openFriendsArrowPos","asset.farmTrainer.openFriends","farmTrainer.openFriendsTipPos",this);
         }
      }
      
      private function petFarmGuildeClear() : void
      {
         if(PetsBagManager.instance().haveTaskOrderByID(367))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(91);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(369))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(101);
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(101);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(370))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(107);
         }
         if(PetsBagManager.instance().haveTaskOrderByID(366))
         {
            PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(114);
         }
      }
      
      protected function initToolBtn() : void
      {
         _farmHelperBtn = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperBtn");
         addChild(_farmHelperBtn);
         MovieClip(_farmHelperBtn.backgound).gotoAndStop(_currentFarmHelperFrame);
         _farmShopBtn = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopBtn");
         addChild(_farmShopBtn);
         _doSeedBtn = ComponentFactory.Instance.creatComponentByStylename("farm.doSeedBtn");
         addChild(_doSeedBtn);
         _doMatureBtn = ComponentFactory.Instance.creatComponentByStylename("farm.doMatureBtn");
         addChild(_doMatureBtn);
         _goHomeBtn = ComponentFactory.Instance.creatComponentByStylename("farm.gohomeBtn");
         addChild(_goHomeBtn);
         if(PathManager.treasureSwitch)
         {
            _goTreasureBtn = ComponentFactory.Instance.creat("asset.treasure.button");
            addChild(_goTreasureBtn);
            PositionUtils.setPos(_goTreasureBtn,"farm.treasure.button.pos");
            _arrangeBtn = ComponentFactory.Instance.creatComponentByStylename("farm.arrangeBtn");
            addChild(_arrangeBtn);
            _arrangeBtn.visible = false;
            _arrangeBtn.tipStyle = null;
         }
         _farmShovelBtn = new FarmKillCropCell();
         addChild(_farmShovelBtn);
         PositionUtils.setPos(_farmShovelBtn,"farm.farmShovelBtn");
         _goHomeBtn.visible = false;
         _farmShovelBtn.visible = true;
      }
      
      private function initEvent() : void
      {
         _farmHelperBtn.addEventListener("rollOver",__farmHelperOver);
         _farmHelperBtn.addEventListener("rollOut",__farmHelperOut);
         _farmHelperBtn.addEventListener("mouseDown",__farmHelperDown);
         _farmHelperBtn.addEventListener("click",__showHelper);
         _doSeedBtn.addEventListener("mouseOver",__doSeedOver);
         _doSeedBtn.addEventListener("mouseOut",__doSeedOut);
         _doMatureBtn.addEventListener("mouseOver",__doMatureOver);
         _doMatureBtn.addEventListener("mouseOut",__doMatureOut);
         _farmShopBtn.addEventListener("mouseOver",__farmShopOver);
         _farmShopBtn.addEventListener("mouseOut",__farmShopOut);
         _goHomeBtn.addEventListener("mouseOver",__goHomeOver);
         _goHomeBtn.addEventListener("mouseOut",__goHomeOut);
         if(_goTreasureBtn)
         {
            _goTreasureBtn.addEventListener("click",__goTreasureBtn);
         }
         _doSeedBtn.addEventListener("click",__onSelectedBtnClick);
         _doMatureBtn.addEventListener("click",__onFastForwardSelectedBtnClick);
         _farmShopBtn.addEventListener("click",__showShop);
         _pastureHouseBtn.addEventListener("click",__pastureHouse);
         _pastureHouseBtn.addEventListener("mouseOver",__pastureOver);
         _pastureHouseBtn.addEventListener("mouseOut",__pastureOut);
         _goHomeBtn.addEventListener("click",__goHomeHandler);
         FarmModelController.instance.addEventListener("fieldsInfoReady",__enterFram);
         PetsBagManager.instance().addEventListener("finish",__updatePetFarmGuilde);
         _fieldView.addEventListener("killcropIcon",__killcrop_iconShow);
         FarmModelController.instance.addEventListener("beginHelper",__setVisible);
         FarmModelController.instance.addEventListener("stopHelper",__setVisibleFal);
         FarmModelController.instance.addEventListener("loaderSuperPetFoodPricetList",__priectListLoadComplete);
         FarmModelController.instance.addEventListener("updateBuyExpRemainNum",__updateNum);
         _bgSprite.addEventListener("click",__onPlayerClick);
         addFieldBlockEvent();
      }
      
      private function __goTreasureBtn(param1:MouseEvent) : void
      {
         TreasureManager.instance.show();
      }
      
      private function __arrangeBackHandler(param1:FarmEvent) : void
      {
         _arrangeBtn.dispatchEvent(new MouseEvent("mouseOut"));
         _arrangeBtn.removeEventListener("mouseOver",__arrangeOver);
         _arrangeBtn.removeEventListener("mouseOut",__arrangeOut);
         _arrangeBtn.removeEventListener("click",__arrangeHandler);
         _arrangeBtn.filterString = "grayFilter,grayFilter,grayFilter,grayFilter";
         _arrangeBtn.tipGapH = 100;
         _arrangeBtn.tipStyle = "ddt.view.tips.OneLineTip";
         if(FarmModelController.instance.model.isArrange)
         {
            _arrangeBtn.tipData = LanguageMgr.GetTranslation("ddt.farm.arrange.tips");
         }
         else
         {
            _arrangeBtn.tipData = LanguageMgr.GetTranslation("ddt.farm.arrange2");
         }
      }
      
      private function addFieldBlockEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _fieldView.fields.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _fieldView.fields[_loc2_].addEventListener("fieldblockclick",__onFieldBlockClick);
            _loc2_++;
         }
      }
      
      protected function __onFieldBlockClick(param1:FarmEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         if(FarmModelController.instance.model.helperArray[0] || FarmModelController.instance.model.currentFarmerId != PlayerManager.Instance.Self.ID)
         {
            return;
         }
         SoundManager.instance.play("008");
         if(_selectedView == null)
         {
            _selectedView = new ManureOrSeedSelectedView();
            addChild(_selectedView);
         }
         var _loc3_:int = _fieldView.fields.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            if(param1.currentTarget == _fieldView.fields[_loc5_])
            {
               _loc2_ = PositionUtils.creatPoint("farm.fieldsView.fieldPos" + _loc5_);
            }
            _loc5_++;
         }
         var _loc4_:Point = PositionUtils.creatPoint("assets.farm.filedbolckRect");
         _selectedView.x = _loc2_.x + _fieldView.x;
         if(_selectedView.x + _selectedView.width > StageReferance.stageWidth - 90)
         {
            _selectedView.x = StageReferance.stageWidth - _selectedView.width - 90;
         }
         _selectedView.y = _loc2_.y + _fieldView.y - _selectedView.height;
         _selectedView.viewType = 1;
      }
      
      protected function __updateNum(param1:FarmEvent) : void
      {
         if(FarmModelController.instance.model.buyExpRemainNum > 0)
         {
            if(_buyExpText)
            {
               _buyExpText.text = FarmModelController.instance.model.buyExpRemainNum.toString();
            }
         }
         else
         {
            _buyExpBtn.visible = false;
            _buyExpText.visible = false;
            _buyExpEffect.visible = false;
         }
      }
      
      protected function __priectListLoadComplete(param1:Event) : void
      {
         _buyExpBtn = UICreatShortcut.creatAndAdd("Farm.FarmMainView.buyExpBtn",this);
         _buyExpText = UICreatShortcut.creatTextAndAdd("Farm.FarmMainView.buyExpNumText","",this);
         _buyExpText.text = FarmModelController.instance.model.buyExpRemainNum.toString();
         _buyExpEffect = UICreatShortcut.creatAndAdd("Farm.FarmMainView.buyExpBtnEffect",this);
         _buyExpBtn.addEventListener("click",__onBuyExpClick);
         if(FarmModelController.instance.model.buyExpRemainNum <= 0)
         {
            _buyExpBtn.visible = false;
            _buyExpText.visible = false;
            _buyExpEffect.visible = false;
         }
         FarmModelController.instance.removeEventListener("loaderSuperPetFoodPricetList",__priectListLoadComplete);
      }
      
      protected function __onBuyExpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         _farmBuyExpFrame = ComponentFactory.Instance.creatComponentByStylename("farm.viewx.farmBuyExpFrame");
         _farmBuyExpFrame.show();
         _farmBuyExpFrame.addEventListener("response",__BuyExpFrameResponse);
      }
      
      protected function __BuyExpFrameResponse(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            SoundManager.instance.playButtonSound();
            if(_farmBuyExpFrame)
            {
               _farmBuyExpFrame.removeEventListener("response",__BuyExpFrameResponse);
            }
            ObjectUtils.disposeObject(_farmBuyExpFrame);
            _farmBuyExpFrame = null;
         }
      }
      
      private function __doSeedOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
      }
      
      private function __doSeedOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
      }
      
      private function __doMatureOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
      }
      
      private function __doMatureOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
      }
      
      private function __farmShopOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
      }
      
      private function __farmShopOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
      }
      
      private function __goHomeOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
      }
      
      private function __goHomeOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
      }
      
      private function __arrangeOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
      }
      
      private function __arrangeOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
      }
      
      private function __arrangeHandler(param1:MouseEvent) : void
      {
         if(!FarmModelController.instance.model.isArrange)
         {
            SoundManager.instance.play("008");
            FarmModelController.instance.arrange();
         }
      }
      
      private function __updatePetFarmGuilde(param1:UpdatePetFarmGuildeEvent) : void
      {
         PetsBagManager.instance().finishTask();
         petFarmGuilde();
      }
      
      private function __killcrop_iconShow(param1:SelectComposeItemEvent) : void
      {
         _farmShovelBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      protected function __pastureOut(param1:MouseEvent) : void
      {
         _pastureHouseBtn.filters = null;
      }
      
      protected function __pastureOver(param1:MouseEvent) : void
      {
         _pastureHouseBtn.filters = SceneCharacterPlayerBase.MOUSE_ON_GLOW_FILTER;
      }
      
      private function setFarmPlayerInfo() : void
      {
         if(_friendPlayer)
         {
            _friendPlayer.dispose();
            _friendPlayer = null;
         }
         deleteSelfPlayer();
         addSelfPlayer();
      }
      
      protected function __enterFram(param1:FarmEvent) : void
      {
         var _loc2_:* = null;
         if(FarmModelController.instance.midAutumnFlag)
         {
            setFarmPlayerInfo();
         }
         if(_arrangeBtn && _arrangeBtn.hasEventListener("click"))
         {
            _arrangeBtn.removeEventListener("mouseOver",__arrangeOver);
            _arrangeBtn.removeEventListener("mouseOut",__arrangeOut);
            _arrangeBtn.removeEventListener("click",__arrangeHandler);
         }
         if(PlayerManager.Instance.Self.ID == FarmModelController.instance.model.currentFarmerId)
         {
            if(PlayerManager.Instance.Self.isFarmHelper)
            {
               setVisibleByAuto(false);
            }
            else
            {
               setVisibleByAuto(true);
            }
         }
         else if(_arrangeBtn && !FarmModelController.instance.model.isArrange)
         {
            _arrangeBtn.addEventListener("mouseOver",__arrangeOver);
            _arrangeBtn.addEventListener("mouseOut",__arrangeOut);
            _arrangeBtn.addEventListener("click",__arrangeHandler);
         }
         _farmName.text = FarmModelController.instance.model.currentFarmerName;
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            petFarmGuilde();
            var _loc3_:* = true;
            _pastureHouseBtn.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _pastureHouseBtn.mouseEnabled = _loc3_;
            _pastureHouseBtn.buttonMode = _loc3_;
            _loc3_ = true;
            _doMatureBtn.visible = _loc3_;
            _loc3_ = _loc3_;
            _doSeedBtn.visible = _loc3_;
            _farmShopBtn.visible = _loc3_;
            _goHomeBtn.visible = false;
            if(_arrangeBtn)
            {
               _arrangeBtn.visible = false;
               _arrangeBtn.tipStyle = null;
            }
            _farmShovelBtn.visible = true;
            _farmHelperBtn.visible = true;
            if(_goTreasureBtn)
            {
               _goTreasureBtn.visible = true;
            }
            if(FarmModelController.instance.model.buyExpRemainNum > 0)
            {
               if(_buyExpBtn)
               {
                  _buyExpBtn.visible = true;
               }
               if(_buyExpText)
               {
                  _buyExpText.visible = true;
               }
               if(_buyExpEffect)
               {
                  _buyExpEffect.visible = true;
               }
            }
            if(PlayerManager.Instance.Self.isFarmHelper)
            {
               if(_startHelperMC)
               {
                  _startHelperMC.visible = true;
               }
            }
         }
         else
         {
            petFarmGuildeClear();
            _loc3_ = false;
            _pastureHouseBtn.mouseChildren = _loc3_;
            _loc3_ = _loc3_;
            _pastureHouseBtn.mouseEnabled = _loc3_;
            _pastureHouseBtn.buttonMode = _loc3_;
            _loc3_ = false;
            _doMatureBtn.visible = _loc3_;
            _loc3_ = _loc3_;
            _doSeedBtn.visible = _loc3_;
            _farmShopBtn.visible = _loc3_;
            _goHomeBtn.visible = true;
            if(_arrangeBtn)
            {
               _arrangeBtn.visible = true;
            }
            if(_arrangeBtn)
            {
               if(FarmModelController.instance.model.isArrange)
               {
                  _arrangeBtn.filterString = "grayFilter,grayFilter,grayFilter,grayFilter";
                  _arrangeBtn.tipData = LanguageMgr.GetTranslation("ddt.farm.arrange.tips");
                  _arrangeBtn.tipStyle = "ddt.view.tips.OneLineTip";
                  _arrangeBtn.tipGapH = 100;
               }
               else
               {
                  _arrangeBtn.filterString = "null,lightFilter,null,grayFilter";
                  _arrangeBtn.tipGapH = -222;
                  _arrangeBtn.tipStyle = null;
               }
            }
            _farmShovelBtn.visible = false;
            _farmHelperBtn.visible = false;
            if(_buyExpBtn)
            {
               _buyExpBtn.visible = false;
            }
            if(_buyExpText)
            {
               _buyExpText.visible = false;
            }
            if(_buyExpEffect)
            {
               _buyExpEffect.visible = false;
            }
            if(_startHelperMC)
            {
               _startHelperMC.visible = false;
            }
            if(_selectedView)
            {
               _selectedView.visible = false;
            }
            if(_goTreasureBtn)
            {
               _goTreasureBtn.visible = false;
            }
            if(FarmModelController.instance.midAutumnFlag)
            {
               _loc2_ = new PlayerVO();
               _loc2_.playerInfo = PlayerManager.Instance.findPlayer(FarmModelController.instance.model.currentFarmerId);
               _currentLoadingPlayer = new FarmPlayer(_loc2_,addPlayerCallBack);
               _currentLoadingPlayer.isChatBall = true;
               _selfPlayer.playerPoint = new Point(356,430);
               _selfPlayer.sceneCharacterDirection = SceneCharacterDirection.LB;
            }
         }
      }
      
      private function __goHomeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FarmModelController.instance.goFarm(PlayerManager.Instance.Self.ID,PlayerManager.Instance.Self.NickName);
         PetsBagManager.instance().clearCurrentPetFarmGuildeArrow(116);
      }
      
      private function __onSelectedBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_selectedView != null)
         {
            _selectedView.dispose();
            _selectedView = null;
         }
         _selectedView = new ManureOrSeedSelectedView();
         addChild(_selectedView);
         PositionUtils.setPos(_selectedView,"farm.seedSelectViewPos");
         var _loc2_:* = param1.currentTarget;
         if(_doSeedBtn !== _loc2_)
         {
            if(_doMatureBtn !== _loc2_)
            {
            }
         }
         else
         {
            _selectedView.viewType = 1;
         }
      }
      
      private function __onFastForwardSelectedBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _needMoney = FarmModelController.instance.gropPrice * ripeNum();
         if(_needMoney == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.farms.noFastForwardInfo"));
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.farms.fastForwardAllInfo",_needMoney),"",LanguageMgr.GetTranslation("cancel"),false,false,false,2,null,"SimpleAlert",30,true,1);
         _loc2_.addEventListener("response",__onResponse);
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:Boolean = (param1.target as BaseAlerFrame).isBand;
         (param1.target as BaseAlerFrame).removeEventListener("response",__onResponse);
         (param1.target as BaseAlerFrame).dispose();
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(_loc2_,_needMoney,onCheckComplete);
         }
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.fastForwardGrop(CheckMoneyUtils.instance.isBind,true,-1);
      }
      
      private function ripeNum() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Vector.<FieldVO> = FarmModelController.instance.model.fieldsInfo;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] && _loc1_[_loc3_].seedID != 0 && _loc1_[_loc3_].realNeedTime > 0)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function __showHelper(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_selectedView)
         {
            _selectedView.visible = false;
         }
         MovieClip(_farmHelperBtn.backgound).gotoAndStop(_currentFarmHelperFrame);
         _farmHelper = ComponentFactory.Instance.creatComponentByStylename("farm.farmHelperView.helper");
         _farmHelper.show();
         _farmHelper.addEventListener("response",__closeHelperView);
      }
      
      private function __closeHelperView(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _farmHelper.removeEventListener("response",__closeHelperView);
         switch(int(param1.responseCode))
         {
            default:
         }
      }
      
      private function __showShop(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _farmShop = ComponentFactory.Instance.creatComponentByStylename("farm.farmShopView.shop");
         _farmShop.addEventListener("response",__closeFarmShop);
         _farmShop.show();
      }
      
      private function __closeFarmShop(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         _farmShop.removeEventListener("response",__closeFarmShop);
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               ObjectUtils.disposeObject(_farmShop);
               _farmShop = null;
         }
      }
      
      private function __pastureHouse(param1:MouseEvent) : void
      {
         if(FarmModelController.instance.model.currentFarmerId == PlayerManager.Instance.Self.ID)
         {
            SoundManager.instance.play("008");
            ToyMachineManager.instance.show();
         }
      }
      
      private function __farmHelperOver(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x - 15;
         MovieClip(_farmHelperBtn.backgound).gotoAndStop(_currentFarmHelperFrame);
      }
      
      private function __farmHelperOut(param1:MouseEvent) : void
      {
         param1.currentTarget.x = param1.currentTarget.x + 15;
         MovieClip(_farmHelperBtn.backgound).gotoAndStop(_currentFarmHelperFrame);
      }
      
      private function __farmHelperDown(param1:MouseEvent) : void
      {
         MovieClip(_farmHelperBtn.backgound).gotoAndStop(_currentFarmHelperFrame);
      }
      
      private function removeEvent() : void
      {
         _farmPoultry.removeEventListener("complete",__onComplete);
         _farmHelperBtn.removeEventListener("rollOver",__farmHelperOver);
         _farmHelperBtn.removeEventListener("rollOut",__farmHelperOut);
         _farmHelperBtn.removeEventListener("mouseDown",__farmHelperDown);
         _farmHelperBtn.removeEventListener("click",__showHelper);
         _doSeedBtn.removeEventListener("mouseOver",__doSeedOver);
         _doSeedBtn.removeEventListener("mouseOut",__doSeedOut);
         _doMatureBtn.removeEventListener("mouseOver",__doMatureOver);
         _doMatureBtn.removeEventListener("mouseOut",__doMatureOut);
         _farmShopBtn.removeEventListener("mouseOver",__farmShopOver);
         _farmShopBtn.removeEventListener("mouseOut",__farmShopOut);
         _goHomeBtn.removeEventListener("mouseOver",__goHomeOver);
         _goHomeBtn.removeEventListener("mouseOut",__goHomeOut);
         _doSeedBtn.removeEventListener("click",__onSelectedBtnClick);
         _doMatureBtn.removeEventListener("click",__onFastForwardSelectedBtnClick);
         _farmShopBtn.removeEventListener("click",__showShop);
         _pastureHouseBtn.removeEventListener("click",__pastureHouse);
         _pastureHouseBtn.removeEventListener("mouseOver",__pastureOver);
         _pastureHouseBtn.removeEventListener("mouseOut",__pastureOut);
         _goHomeBtn.removeEventListener("click",__goHomeHandler);
         if(_buyExpBtn)
         {
            _buyExpBtn.removeEventListener("click",__onBuyExpClick);
         }
         FarmModelController.instance.removeEventListener("fieldsInfoReady",__enterFram);
         PetsBagManager.instance().removeEventListener("finish",__updatePetFarmGuilde);
         _fieldView.removeEventListener("killcropIcon",__killcrop_iconShow);
         FarmModelController.instance.removeEventListener("beginHelper",__setVisible);
         FarmModelController.instance.removeEventListener("stopHelper",__setVisibleFal);
         FarmModelController.instance.removeEventListener("loaderSuperPetFoodPricetList",__priectListLoadComplete);
         FarmModelController.instance.removeEventListener("updateBuyExpRemainNum",__updateNum);
         if(_goTreasureBtn)
         {
            _goTreasureBtn.removeEventListener("click",__goTreasureBtn);
         }
         if(_arrangeBtn && _arrangeBtn.hasEventListener("click"))
         {
            _arrangeBtn.removeEventListener("mouseOver",__arrangeOver);
            _arrangeBtn.removeEventListener("mouseOut",__arrangeOut);
            _arrangeBtn.removeEventListener("click",__arrangeHandler);
         }
         removeFieldBolckEvent();
         SocketManager.Instance.removeEventListener(PkgEvent.format(81,21),__onGetPoultryLevel);
      }
      
      private function removeFieldBolckEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _fieldView.fields.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _fieldView.fields[_loc2_].removeEventListener("fieldblockclick",__onFieldBlockClick);
            _loc2_++;
         }
      }
      
      private function deleteSelfPlayer() : void
      {
         if(_selfPlayer)
         {
            _selfPlayer.removeEventListener("characterActionChange",playerActionChange);
            removeEventListener("enterFrame",__updateFrame);
            _selfPlayer.dispose();
            _selfPlayer = null;
         }
         if(_sceneScene)
         {
            _sceneScene.dispose();
            _sceneScene = null;
         }
         ObjectUtils.disposeObject(_mouseMovie);
         _mouseMovie = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_water)
         {
            ObjectUtils.disposeObject(_water);
         }
         _water = null;
         if(_water1)
         {
            ObjectUtils.disposeObject(_water1);
         }
         _water1 = null;
         if(_waterwheel)
         {
            ObjectUtils.disposeObject(_waterwheel);
         }
         _waterwheel = null;
         if(_float)
         {
            ObjectUtils.disposeObject(_float);
         }
         _float = null;
         if(_pastureHouseBtn)
         {
            ObjectUtils.disposeObject(_pastureHouseBtn);
         }
         _pastureHouseBtn = null;
         if(_friendListView)
         {
            ObjectUtils.disposeObject(_friendListView);
         }
         _friendListView = null;
         if(_farmHelperBtn)
         {
            ObjectUtils.disposeObject(_farmHelperBtn);
         }
         _farmHelperBtn = null;
         if(_farmShopBtn)
         {
            ObjectUtils.disposeObject(_farmShopBtn);
         }
         _farmShopBtn = null;
         if(_doSeedBtn)
         {
            ObjectUtils.disposeObject(_doSeedBtn);
         }
         _doSeedBtn = null;
         if(_doMatureBtn)
         {
            ObjectUtils.disposeObject(_doMatureBtn);
         }
         _doMatureBtn = null;
         if(_goTreasureBtn)
         {
            ObjectUtils.disposeObject(_goTreasureBtn);
         }
         _goTreasureBtn = null;
         if(_goHomeBtn)
         {
            ObjectUtils.disposeObject(_goHomeBtn);
         }
         _goHomeBtn = null;
         if(_arrangeBtn)
         {
            ObjectUtils.disposeObject(_arrangeBtn);
         }
         _arrangeBtn = null;
         if(_fireflyMC1)
         {
            ObjectUtils.disposeObject(_fireflyMC1);
         }
         _fireflyMC1 = null;
         if(_fireflyMC2)
         {
            ObjectUtils.disposeObject(_fireflyMC2);
         }
         _fireflyMC2 = null;
         if(_fireflyMC3)
         {
            ObjectUtils.disposeObject(_fireflyMC3);
         }
         _fireflyMC3 = null;
         if(_fieldView)
         {
            ObjectUtils.disposeObject(_fieldView);
         }
         _fieldView = null;
         if(_startHelperMC)
         {
            ObjectUtils.disposeObject(_startHelperMC);
         }
         _startHelperMC = null;
         if(_hostNameBmp)
         {
            ObjectUtils.disposeObject(_hostNameBmp);
         }
         _hostNameBmp = null;
         if(_farmName)
         {
            ObjectUtils.disposeObject(_farmName);
         }
         _farmName = null;
         if(_selectedView)
         {
            ObjectUtils.disposeObject(_selectedView);
         }
         _selectedView = null;
         if(_farmShovelBtn)
         {
            _farmShovelBtn.dispose();
         }
         _farmShovelBtn = null;
         if(_newPetPao)
         {
            ObjectUtils.disposeObject(_newPetPao);
         }
         _newPetPao = null;
         if(_newdragon)
         {
            ObjectUtils.disposeObject(_newdragon);
         }
         _newdragon = null;
         if(_newPetText)
         {
            ObjectUtils.disposeObject(_newPetText);
         }
         _newPetText = null;
         if(_farmBuyExpFrame)
         {
            _farmBuyExpFrame.removeEventListener("response",__BuyExpFrameResponse);
         }
         ObjectUtils.disposeObject(_buyExpText);
         _buyExpText = null;
         ObjectUtils.disposeObject(_buyExpEffect);
         _buyExpEffect = null;
         ObjectUtils.disposeObject(_buyExpBtn);
         _buyExpBtn = null;
         ObjectUtils.disposeObject(_farmBuyExpFrame);
         _farmBuyExpFrame = null;
         if(_bgSprite)
         {
            _bgSprite.removeEventListener("click",__onPlayerClick);
            ObjectUtils.disposeObject(_bgSprite);
            _bgSprite = null;
         }
         deleteSelfPlayer();
         if(_meshLayer)
         {
            ObjectUtils.disposeObject(_meshLayer);
         }
         _meshLayer = null;
         if(_farmTree)
         {
            ObjectUtils.disposeObject(_farmTree);
         }
         _farmTree = null;
         if(_farmPoultry)
         {
            ObjectUtils.disposeObject(_farmPoultry);
         }
         _farmPoultry = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
