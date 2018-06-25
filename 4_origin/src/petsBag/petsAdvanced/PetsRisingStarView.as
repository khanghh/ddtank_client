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
         var i:int = 0;
         var petTempleteInfo:* = null;
         var propArr:* = null;
         var growArr:* = null;
         var p1:int = 0;
         var p2:int = 0;
         var p3:int = 0;
         var k:int = 0;
         if(_petInfo == null)
         {
            return;
         }
         var __list:Vector.<PetStarExpData> = PetsAdvancedManager.Instance.risingStarDataList;
         var _loc12_:* = 0;
         var _loc11_:* = __list;
         for each(var info in __list)
         {
            if(info.OldID == _petInfo.TemplateID)
            {
               _petStarInfo = info;
               _progress.max = _petStarInfo.Exp;
               _progress.setProgress(_petInfo.currentStarExp);
               break;
            }
         }
         if(_petInfo.StarLevel >= 5)
         {
            _tip.tipData = "0/0";
            for(i = 0; i < 5; )
            {
               _itemVector[i].setData(i,0,0);
               i++;
            }
            _progress.maxAdvancedGrade();
         }
         else if(_petStarInfo)
         {
            petTempleteInfo = PetInfoManager.getPetByTemplateID(_petStarInfo.NewID);
            if(!petTempleteInfo)
            {
               return;
            }
            _oldPropArr = [petTempleteInfo.HighBlood,petTempleteInfo.HighAttack,petTempleteInfo.HighDefence,petTempleteInfo.HighAgility,petTempleteInfo.HighLuck];
            _oldGrowArr = [petTempleteInfo.HighBloodGrow,petTempleteInfo.HighAttackGrow,petTempleteInfo.HighDefenceGrow,petTempleteInfo.HighAgilityGrow,petTempleteInfo.HighLuckGrow];
            _propLevelArr_one = _oldPropArr;
            _growLevelArr_one = getAddedPropArr(1,_oldGrowArr);
            _propLevelArr_two = _oldPropArr;
            _growLevelArr_two = getAddedPropArr(2,_oldGrowArr);
            _propLevelArr_three = _oldPropArr;
            _growLevelArr_three = getAddedPropArr(3,_oldGrowArr);
            if(_petInfo.Level < 30)
            {
               for(p1 = 0; p1 < _propLevelArr_one.length; )
               {
                  _loc12_ = p1;
                  _loc11_ = _propLevelArr_one[_loc12_] + ((_petInfo.Level - 1) * _growLevelArr_one[p1] - _currentPropArr[p1]);
                  _propLevelArr_one[_loc12_] = _loc11_;
                  _loc11_ = p1;
                  _loc12_ = _growLevelArr_one[_loc11_] - _currentGrowArr[p1];
                  _growLevelArr_one[_loc11_] = _loc12_;
                  _propLevelArr_one[p1] = Math.ceil(_propLevelArr_one[p1] / 10) / 10;
                  _growLevelArr_one[p1] = Math.ceil(_growLevelArr_one[p1] / 10) / 10;
                  p1++;
               }
               propArr = _propLevelArr_one;
               growArr = _growLevelArr_one;
            }
            else if(_petInfo.Level < 50)
            {
               for(p2 = 0; p2 < _propLevelArr_two.length; )
               {
                  _loc12_ = p2;
                  _loc11_ = _propLevelArr_two[_loc12_] + ((_petInfo.Level - 30) * _growLevelArr_two[p2] + 29 * _growLevelArr_one[p2] - _currentPropArr[p2]);
                  _propLevelArr_two[_loc12_] = _loc11_;
                  _loc11_ = p2;
                  _loc12_ = _growLevelArr_two[_loc11_] - _currentGrowArr[p2];
                  _growLevelArr_two[_loc11_] = _loc12_;
                  _propLevelArr_two[p2] = Math.ceil(_propLevelArr_two[p2] / 10) / 10;
                  _growLevelArr_two[p2] = Math.ceil(_growLevelArr_two[p2] / 10) / 10;
                  p2++;
               }
               propArr = _propLevelArr_two;
               growArr = _growLevelArr_two;
            }
            else
            {
               p3 = 0;
               while(p3 < _propLevelArr_three.length)
               {
                  _loc12_ = p3;
                  _loc11_ = _propLevelArr_three[_loc12_] + ((_petInfo.Level - 50) * _growLevelArr_three[p3] + 20 * _growLevelArr_two[p3] + 29 * _growLevelArr_one[p3] - _currentPropArr[p3]);
                  _propLevelArr_three[_loc12_] = _loc11_;
                  _loc11_ = p3;
                  _loc12_ = _growLevelArr_three[_loc11_] - _currentGrowArr[p3];
                  _growLevelArr_three[_loc11_] = _loc12_;
                  _propLevelArr_three[p3] = Math.ceil(_propLevelArr_three[p3] / 10) / 10;
                  _growLevelArr_three[p3] = Math.ceil(_growLevelArr_three[p3] / 10) / 10;
                  p3++;
               }
               propArr = _propLevelArr_three;
               growArr = _growLevelArr_three;
            }
            for(k = 0; k < 5; )
            {
               _itemVector[k].setData(k,propArr[k],growArr[k]);
               k++;
            }
         }
      }
      
      private function getAddedPropArr(grade:int, propArr:Array) : Array
      {
         var i:int = 0;
         var arr:Array = [];
         arr.push(propArr[0] * Math.pow(2,grade - 1));
         for(i = 1; i < 5; )
         {
            arr.push(propArr[i] * Math.pow(1.5,grade - 1));
            i++;
         }
         return arr;
      }
      
      override protected function __enterFrame(event:Event) : void
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
      
      protected function __risingStarHandler(event:PkgEvent) : void
      {
         _petInfo = PetsBagManager.instance().petModel.currentPetInfo;
         var pkg:PackageIn = event.pkg;
         var success:Boolean = pkg.readBoolean();
         if(success)
         {
            _btn.enable = false;
         }
         _bagCell.updateCount();
         _progress.setProgress(_petInfo.currentStarExp,success);
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
