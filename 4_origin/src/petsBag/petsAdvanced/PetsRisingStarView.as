package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PetInfoManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import pet.data.PetTemplateInfo;
   import petsBag.PetsBagManager;
   import petsBag.data.PetStarExpData;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   import petsBag.view.item.StarBar;
   import road7th.comm.PackageIn;
   
   public class PetsRisingStarView extends PetsAdvancedView
   {
       
      
      private var _starBar:StarBar;
      
      private var _maxStarTxt:FilterFrameText;
      
      private var _helpTxt1:FilterFrameText;
      
      private var _helpTxt2:FilterFrameText;
      
      private var _helpTxt3:FilterFrameText;
      
      private var _petStarInfo:PetStarExpData;
      
      private var _oldPropArr:Array;
      
      private var _oldGrowArr:Array;
      
      private var _propLevelArr_one:Array;
      
      private var _propLevelArr_two:Array;
      
      private var _propLevelArr_three:Array;
      
      private var _growLevelArr_one:Array;
      
      private var _growLevelArr_two:Array;
      
      private var _growLevelArr_three:Array;
      
      public function PetsRisingStarView()
      {
         super(1);
      }
      
      override protected function initView() : void
      {
         super.initView();
         _maxStarTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.helpTxt");
         _maxStarTxt.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.maxStarTxt");
         PositionUtils.setPos(_maxStarTxt,"petsBag.risingStar.maxStarPos");
         addChild(_maxStarTxt);
         if(_petInfo && _petInfo.StarLevel == 5)
         {
            _maxStarTxt.visible = true;
         }
         else
         {
            _maxStarTxt.visible = false;
            _starBar = new StarBar();
            _starBar.starNum(_petInfo != null?_petInfo.StarLevel + 1:0);
            PositionUtils.setPos(_starBar,"petsBag.risingStar.nextStarPos");
            addChild(_starBar);
         }
         _helpTxt1 = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.helpTxt");
         addChild(_helpTxt1);
         _helpTxt1.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.helpTxt1");
         _helpTxt2 = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.helpTxt");
         addChild(_helpTxt2);
         _helpTxt2.y = _helpTxt1.y + 15;
         _helpTxt2.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.helpTxt2");
         _helpTxt3 = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.helpTxt");
         addChild(_helpTxt3);
         _helpTxt3.y = _helpTxt2.y + 30;
         _helpTxt3.text = LanguageMgr.GetTranslation("ddt.pets.risingStar.helpTxt3");
         if(_petInfo && _petInfo.StarLevel >= 5)
         {
            _btn.enable = false;
         }
      }
      
      override protected function initData() : void
      {
         super.initData();
         updateData();
      }
      
      private function updateData() : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc1_:* = null;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         if(_petInfo == null)
         {
            return;
         }
         var _loc8_:Vector.<PetStarExpData> = PetsAdvancedManager.Instance.risingStarDataList;
         var _loc12_:* = 0;
         var _loc11_:* = _loc8_;
         for each(var _loc10_ in _loc8_)
         {
            if(_loc10_.OldID == _petInfo.TemplateID)
            {
               _petStarInfo = _loc10_;
               _progress.max = _petStarInfo.Exp;
               _progress.setProgress(_petInfo.currentStarExp);
               break;
            }
         }
         if(_petInfo.StarLevel >= 5)
         {
            _tip.tipData = "0/0";
            _loc9_ = 0;
            while(_loc9_ < 5)
            {
               _itemVector[_loc9_].setData(_loc9_,0,0);
               _loc9_++;
            }
            _progress.maxAdvancedGrade();
         }
         else if(_petStarInfo)
         {
            _loc6_ = PetInfoManager.getPetByTemplateID(_petStarInfo.NewID);
            if(!_loc6_)
            {
               return;
            }
            _oldPropArr = [_loc6_.HighBlood,_loc6_.HighAttack,_loc6_.HighDefence,_loc6_.HighAgility,_loc6_.HighLuck];
            _oldGrowArr = [_loc6_.HighBloodGrow,_loc6_.HighAttackGrow,_loc6_.HighDefenceGrow,_loc6_.HighAgilityGrow,_loc6_.HighLuckGrow];
            _propLevelArr_one = _oldPropArr;
            _growLevelArr_one = getAddedPropArr(1,_oldGrowArr);
            _propLevelArr_two = _oldPropArr;
            _growLevelArr_two = getAddedPropArr(2,_oldGrowArr);
            _propLevelArr_three = _oldPropArr;
            _growLevelArr_three = getAddedPropArr(3,_oldGrowArr);
            if(_petInfo.Level < 30)
            {
               _loc4_ = 0;
               while(_loc4_ < _propLevelArr_one.length)
               {
                  _loc12_ = _loc4_;
                  _loc11_ = _propLevelArr_one[_loc12_] + ((_petInfo.Level - 1) * _growLevelArr_one[_loc4_] - _currentPropArr[_loc4_]);
                  _propLevelArr_one[_loc12_] = _loc11_;
                  _loc11_ = _loc4_;
                  _loc12_ = _growLevelArr_one[_loc11_] - _currentGrowArr[_loc4_];
                  _growLevelArr_one[_loc11_] = _loc12_;
                  _propLevelArr_one[_loc4_] = Math.ceil(_propLevelArr_one[_loc4_] / 10) / 10;
                  _growLevelArr_one[_loc4_] = Math.ceil(_growLevelArr_one[_loc4_] / 10) / 10;
                  _loc4_++;
               }
               _loc1_ = _propLevelArr_one;
               _loc5_ = _growLevelArr_one;
            }
            else if(_petInfo.Level < 50)
            {
               _loc3_ = 0;
               while(_loc3_ < _propLevelArr_two.length)
               {
                  _loc12_ = _loc3_;
                  _loc11_ = _propLevelArr_two[_loc12_] + ((_petInfo.Level - 30) * _growLevelArr_two[_loc3_] + 29 * _growLevelArr_one[_loc3_] - _currentPropArr[_loc3_]);
                  _propLevelArr_two[_loc12_] = _loc11_;
                  _loc11_ = _loc3_;
                  _loc12_ = _growLevelArr_two[_loc11_] - _currentGrowArr[_loc3_];
                  _growLevelArr_two[_loc11_] = _loc12_;
                  _propLevelArr_two[_loc3_] = Math.ceil(_propLevelArr_two[_loc3_] / 10) / 10;
                  _growLevelArr_two[_loc3_] = Math.ceil(_growLevelArr_two[_loc3_] / 10) / 10;
                  _loc3_++;
               }
               _loc1_ = _propLevelArr_two;
               _loc5_ = _growLevelArr_two;
            }
            else
            {
               _loc2_ = 0;
               while(_loc2_ < _propLevelArr_three.length)
               {
                  _loc12_ = _loc2_;
                  _loc11_ = _propLevelArr_three[_loc12_] + ((_petInfo.Level - 50) * _growLevelArr_three[_loc2_] + 20 * _growLevelArr_two[_loc2_] + 29 * _growLevelArr_one[_loc2_] - _currentPropArr[_loc2_]);
                  _propLevelArr_three[_loc12_] = _loc11_;
                  _loc11_ = _loc2_;
                  _loc12_ = _growLevelArr_three[_loc11_] - _currentGrowArr[_loc2_];
                  _growLevelArr_three[_loc11_] = _loc12_;
                  _propLevelArr_three[_loc2_] = Math.ceil(_propLevelArr_three[_loc2_] / 10) / 10;
                  _growLevelArr_three[_loc2_] = Math.ceil(_growLevelArr_three[_loc2_] / 10) / 10;
                  _loc2_++;
               }
               _loc1_ = _propLevelArr_three;
               _loc5_ = _growLevelArr_three;
            }
            _loc7_ = 0;
            while(_loc7_ < 5)
            {
               _itemVector[_loc7_].setData(_loc7_,_loc1_[_loc7_],_loc5_[_loc7_]);
               _loc7_++;
            }
         }
      }
      
      private function getAddedPropArr(param1:int, param2:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         _loc3_.push(param2[0] * Math.pow(2,param1 - 1));
         _loc4_ = 1;
         while(_loc4_ < 5)
         {
            _loc3_.push(param2[_loc4_] * Math.pow(1.5,param1 - 1));
            _loc4_++;
         }
         return _loc3_;
      }
      
      override protected function __enterFrame(param1:Event) : void
      {
         if(!_starMc)
         {
            return;
         }
         if(_starMc.currentFrame == 100)
         {
            _petsBasicInfoView.dispatchEvent(new PetsAdvancedEvent("starOrGrade_movie_complete"));
            playNumMovie();
            updatePetData();
            updateData();
         }
         else if(_starMc.currentFrame >= 110)
         {
            _starMc.stop();
            removeChild(_starMc);
            updateView();
            _starMc = null;
            removeEventListener("enterFrame",__enterFrame);
         }
      }
      
      private function updateView() : void
      {
         _petsBasicInfoView.updateStar(_petInfo.StarLevel);
         if(_petInfo.StarLevel < 5)
         {
            _starBar.starNum(_petInfo.StarLevel + 1);
         }
         else
         {
            ObjectUtils.disposeObject(_starBar);
            _starBar = null;
            _maxStarTxt.visible = true;
         }
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         SocketManager.Instance.addEventListener(PkgEvent.format(68,22),__risingStarHandler);
      }
      
      protected function __risingStarHandler(param1:PkgEvent) : void
      {
         _petInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         if(_loc3_)
         {
            _btn.enable = false;
         }
         _bagCell.updateCount();
         _progress.setProgress(_petInfo.currentStarExp,_loc3_);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,22),__risingStarHandler);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_starBar);
         _starBar = null;
         ObjectUtils.disposeObject(_maxStarTxt);
         _maxStarTxt = null;
         ObjectUtils.disposeObject(_helpTxt1);
         _helpTxt1 = null;
         ObjectUtils.disposeObject(_helpTxt2);
         _helpTxt2 = null;
         ObjectUtils.disposeObject(_helpTxt3);
         _helpTxt3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}
