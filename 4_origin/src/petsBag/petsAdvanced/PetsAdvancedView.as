package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.SelfInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import ddtDeed.DeedManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   
   public class PetsAdvancedView extends Sprite implements Disposeable
   {
       
      
      protected var _bg:Bitmap;
      
      protected var _petInfo:PetInfo;
      
      protected var _petsBasicInfoView:PetsBasicInfoView;
      
      protected var _viewType:int;
      
      protected var _vBox:VBox;
      
      protected var _itemVector:Vector.<PetsPropItem>;
      
      protected var _btn:SimpleBitmapButton;
      
      protected var _freeBtn:SimpleBitmapButton;
      
      protected var _freeTxt:FilterFrameText;
      
      protected var _allBtn:SelectedCheckButton;
      
      protected var _bagCellBg:Bitmap;
      
      protected var _bagCell:PetsAdvancedCell;
      
      protected var _progress:PetsAdvancedProgressBar;
      
      protected var _starMc:MovieClip;
      
      protected var _gradeMc:MovieClip;
      
      protected var _currentEvolutionExp:int;
      
      protected var _currentPropArr:Array;
      
      protected var _currentGrowArr:Array;
      
      protected var _toLinkTxt:FilterFrameText;
      
      protected var _tip:OneLineTip;
      
      protected var _self:SelfInfo;
      
      private var _clickDate:Number = 0;
      
      public function PetsAdvancedView(param1:int)
      {
         super();
         _viewType = param1;
         _petInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _itemVector = new Vector.<PetsPropItem>();
         _self = PlayerManager.Instance.Self;
         initView();
         initData();
         addEvent();
      }
      
      protected function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_viewType == 1)
         {
            _bg = ComponentFactory.Instance.creat("petsBag.risingStar.petsBag.bg");
         }
         else
         {
            _bg = ComponentFactory.Instance.creat("petsBag.evolution.bg");
         }
         addChild(_bg);
         _petsBasicInfoView = new PetsBasicInfoView();
         addChild(_petsBasicInfoView);
         _vBox = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.vBox");
         addChild(_vBox);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new PetsPropItem(_viewType);
            _itemVector.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.allRisingStarBtn");
         addChild(_allBtn);
         _allBtn.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.tisingStarTxt");
         _progress = new PetsAdvancedProgressBar();
         addChild(_progress);
         _tip = new OneLineTip();
         _tip.visible = false;
         addChild(_tip);
         if(_viewType == 1)
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.risingStarbtn");
            addChild(_btn);
            _freeBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.risingStarbtn2");
            addChild(_freeBtn);
            _freeTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.risingStarbtn2txt");
            addChild(_freeTxt);
            PositionUtils.setPos(_progress,"petsBag.risingStar.progressPos");
            PositionUtils.setPos(_tip,"petsBag.risingStar.tipPos");
         }
         else
         {
            _btn = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.evolutionBtn");
            addChild(_btn);
            _freeBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.evolutionBtn2");
            addChild(_freeBtn);
            _freeTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.evolutionBtn2txt");
            addChild(_freeTxt);
            PositionUtils.setPos(_allBtn,"petsBag.evolution.allEvolutionBtnPos");
            PositionUtils.setPos(_progress,"petsBag.evolution.progressPos");
            PositionUtils.setPos(_tip,"petsBag.evolution.tipPos");
         }
         _bagCellBg = ComponentFactory.Instance.creat("petsBag.risingStar.bagCellBg");
         PositionUtils.setPos(_bagCellBg,"petsBag.advaced.bagCellBg" + _viewType);
         var _loc3_:* = 0.8;
         _bagCellBg.scaleY = _loc3_;
         _bagCellBg.scaleX = _loc3_;
         addChild(_bagCellBg);
         _bagCell = new PetsAdvancedCell();
         PositionUtils.setPos(_bagCell,"petsBag.advaced.petAdvancedCellPos" + _viewType);
         addChild(_bagCell);
         _toLinkTxt = ComponentFactory.Instance.creat("petAndHorse.risingStar.toLinkTxt");
         _toLinkTxt.mouseEnabled = true;
         _toLinkTxt.htmlText = LanguageMgr.GetTranslation("petAndHorse.risingStar.toLinkTxtValue");
         PositionUtils.setPos(_toLinkTxt,"petAndHorse.risingStar.toLinkTxtPos" + _viewType);
         addChild(_toLinkTxt);
         refreshFreeTipTxt();
      }
      
      protected function addEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
         _freeBtn.addEventListener("click",__clickHandler);
         _progress.addEventListener("progress_movie_complete",__progressMovieHandler);
         _petsBasicInfoView.addEventListener("all_movie_complete",__allComplete);
         _progress.addEventListener("rollOver",__showTip);
         _progress.addEventListener("rollOut",__hideTip);
         _toLinkTxt.addEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.addEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.addEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      private function refreshFreeTipTxt(param1:Event = null) : void
      {
         var _loc3_:int = DeedManager.instance.getOneBuffData(10);
         var _loc2_:int = DeedManager.instance.getOneBuffData(11);
         if(_viewType == 1)
         {
            if(_loc3_ > 0 && _petInfo.StarLevel < 5)
            {
               _freeBtn.visible = true;
               _freeTxt.visible = true;
               _freeTxt.text = "(" + _loc3_ + ")";
               _btn.visible = false;
            }
            else
            {
               _freeTxt.text = "(" + _loc3_ + ")";
               _freeBtn.visible = false;
               _freeTxt.visible = false;
               _btn.visible = true;
            }
         }
         else if(_viewType == 2)
         {
            if(_loc2_ > 0 && _self.evolutionGrade < PetsAdvancedManager.Instance.evolutionDataList.length)
            {
               _freeBtn.visible = true;
               _freeTxt.visible = true;
               _freeTxt.text = "(" + _loc2_ + ")";
               _btn.visible = false;
            }
            else
            {
               _freeTxt.text = "(" + _loc2_ + ")";
               _freeBtn.visible = false;
               _freeTxt.visible = false;
               _btn.visible = true;
            }
         }
      }
      
      protected function __hideTip(param1:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      protected function __showTip(param1:MouseEvent) : void
      {
         _tip.tipData = _progress.currentExp + "/" + _progress.max;
         _tip.visible = true;
      }
      
      protected function playNumMovie() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemVector.length)
         {
            _itemVector[_loc1_].playNumMc();
            _loc1_++;
         }
      }
      
      protected function __allComplete(param1:Event) : void
      {
         if(_viewType == 1)
         {
            if(_petInfo.StarLevel < 5)
            {
               _btn.enable = true;
            }
            else
            {
               _btn.enable = false;
            }
         }
         else if(_self.evolutionGrade < PetsAdvancedManager.Instance.evolutionDataList.length)
         {
            _btn.enable = true;
         }
         else
         {
            _btn.enable = false;
         }
         PetsAdvancedControl.Instance.isAllMovieComplete = true;
         PetsAdvancedControl.Instance.frame.enableBtn = true;
      }
      
      protected function __progressMovieHandler(param1:PetsAdvancedEvent) : void
      {
         if(_viewType == 1)
         {
            _starMc = ComponentFactory.Instance.creat("petsBag.risingStar.starMc");
            addChild(_starMc);
            PositionUtils.setPos(_starMc,"petsBag.risingStar.starMcPos" + _petInfo.StarLevel);
         }
         else
         {
            _gradeMc = ComponentFactory.Instance.creat("petsBag.evolution.gradeMc");
            _gradeMc.rotation = 44;
            addChild(_gradeMc);
            PositionUtils.setPos(_gradeMc,"petsBag.evolution.gradeMcPos");
         }
         addEventListener("enterFrame",__enterFrame);
      }
      
      protected function __enterFrame(param1:Event) : void
      {
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(new Date().time - _clickDate <= 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         _clickDate = new Date().time;
         SoundManager.instance.playButtonSound();
         if(_viewType == 2 && !_petInfo.IsEquip)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.evolution.cannotEvolutionTxt"));
            return;
         }
         var _loc8_:int = DeedManager.instance.getOneBuffData(10);
         var _loc7_:int = DeedManager.instance.getOneBuffData(11);
         if(_viewType == 1 && _loc8_ > 0)
         {
            SocketManager.Instance.out.sendPetRisingStar(_bagCell.getTempleteId(),1,_petInfo.Place);
            return;
         }
         if(_viewType == 2 && _loc7_ > 0)
         {
            SocketManager.Instance.out.sendPetEvolution(_bagCell.getTempleteId(),1);
            return;
         }
         if(_bagCell.getCount() == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.pets.advanced.noPropTxt",_bagCell.getPropName()));
            return;
         }
         var _loc2_:int = _bagCell.getExpOfBagcell();
         var _loc5_:int = _bagCell.getTempleteId();
         if(_allBtn.selected)
         {
            _loc4_ = Math.ceil((_progress.max - _progress.currentExp) / _loc2_);
            _loc3_ = _loc4_ < _bagCell.getCount()?_loc4_:int(_bagCell.getCount());
         }
         else
         {
            _loc3_ = 1;
         }
         var _loc6_:int = _petInfo.Place;
         if(_viewType == 1)
         {
            SocketManager.Instance.out.sendPetRisingStar(_loc5_,_loc3_,_loc6_);
         }
         else
         {
            SocketManager.Instance.out.sendPetEvolution(_loc5_,_loc3_);
         }
      }
      
      protected function initData() : void
      {
         updatePetData();
      }
      
      protected function updatePetData() : void
      {
         if(_petInfo != null)
         {
            _currentPropArr = [_petInfo.Blood * 100,_petInfo.Attack * 100,_petInfo.Defence * 100,_petInfo.Agility * 100,_petInfo.Luck * 100];
            _currentGrowArr = [_petInfo.BloodGrow,_petInfo.AttackGrow,_petInfo.DefenceGrow,_petInfo.AgilityGrow,_petInfo.LuckGrow];
            _petsBasicInfoView.setInfo(_petInfo);
         }
      }
      
      private function __toLinkTxtHandler(param1:TextEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StateManager.setState("dungeon");
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("enterFrame",__enterFrame);
         _btn.removeEventListener("click",__clickHandler);
         _freeBtn.removeEventListener("click",__clickHandler);
         _progress.removeEventListener("progress_movie_complete",__progressMovieHandler);
         _petsBasicInfoView.removeEventListener("all_movie_complete",__allComplete);
         _progress.removeEventListener("rollOver",__showTip);
         _progress.removeEventListener("rollOut",__hideTip);
         _toLinkTxt.removeEventListener("link",__toLinkTxtHandler);
         DeedManager.instance.removeEventListener("update_buff_data_event",refreshFreeTipTxt);
         DeedManager.instance.removeEventListener("update_main_event",refreshFreeTipTxt);
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _itemVector;
         for each(var _loc1_ in _itemVector)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemVector = null;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_petsBasicInfoView);
         _petsBasicInfoView = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_freeBtn);
         _freeBtn = null;
         ObjectUtils.disposeObject(_freeTxt);
         _freeTxt = null;
         ObjectUtils.disposeObject(_allBtn);
         _allBtn = null;
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         ObjectUtils.disposeObject(_bagCellBg);
         _bagCellBg = null;
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_starMc);
         _starMc = null;
         ObjectUtils.disposeObject(_gradeMc);
         _gradeMc = null;
         ObjectUtils.disposeObject(_toLinkTxt);
         _toLinkTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
