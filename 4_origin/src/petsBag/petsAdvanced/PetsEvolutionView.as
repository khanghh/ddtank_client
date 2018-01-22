package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import petsBag.data.PetFightPropertyData;
   import petsBag.petsAdvanced.event.PetsAdvancedEvent;
   import road7th.comm.PackageIn;
   
   public class PetsEvolutionView extends PetsAdvancedView
   {
       
      
      private var _attackTxt:FilterFrameText;
      
      private var _attackAddedTxt:FilterFrameText;
      
      private var _defenceTxt:FilterFrameText;
      
      private var _defenceAddedTxt:FilterFrameText;
      
      private var _agilityTxt:FilterFrameText;
      
      private var _agilityAddedTxt:FilterFrameText;
      
      private var _luckTxt:FilterFrameText;
      
      private var _luckAddedTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _hpAddedTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _evolutionGradeTxt:FilterFrameText;
      
      private var _currentGradeInfo:PetFightPropertyData;
      
      private var _nextGradeInfo:PetFightPropertyData;
      
      public function PetsEvolutionView()
      {
         super(2);
      }
      
      override protected function initView() : void
      {
         super.initView();
         PositionUtils.setPos(_vBox,"petsBag.evolution.vBoxPos");
         _evolutionGradeTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.evolutionGradeTxt");
         addChild(_evolutionGradeTxt);
         _evolutionGradeTxt.text = "LV." + _self.evolutionGrade;
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_attackTxt);
         _attackTxt.text = LanguageMgr.GetTranslation("attack");
         PositionUtils.setPos(_attackTxt,"petsBag.evolution.attackPos");
         _attackAddedTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.propValueTxt");
         addChild(_attackAddedTxt);
         _attackAddedTxt.x = _attackTxt.x + 55;
         _attackAddedTxt.y = _attackTxt.y;
         _attackAddedTxt.text = "0";
         _defenceTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_defenceTxt);
         _defenceTxt.text = LanguageMgr.GetTranslation("defence");
         PositionUtils.setPos(_defenceTxt,"petsBag.evolution.defencePos");
         _defenceAddedTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.propValueTxt");
         addChild(_defenceAddedTxt);
         _defenceAddedTxt.x = _defenceTxt.x + 55;
         _defenceAddedTxt.y = _defenceTxt.y;
         _defenceAddedTxt.text = "0";
         _agilityTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_agilityTxt);
         _agilityTxt.text = LanguageMgr.GetTranslation("agility");
         PositionUtils.setPos(_agilityTxt,"petsBag.evolution.agilityPos");
         _agilityAddedTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.propValueTxt");
         addChild(_agilityAddedTxt);
         _agilityAddedTxt.x = _agilityTxt.x + 55;
         _agilityAddedTxt.y = _agilityTxt.y;
         _agilityAddedTxt.text = "0";
         _luckTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_luckTxt);
         _luckTxt.text = LanguageMgr.GetTranslation("luck");
         PositionUtils.setPos(_luckTxt,"petsBag.evolution.hurtPos");
         _luckAddedTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.propValueTxt");
         addChild(_luckAddedTxt);
         _luckAddedTxt.x = _luckTxt.x + 55;
         _luckAddedTxt.y = _luckTxt.y;
         _luckAddedTxt.text = "0";
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_hpTxt);
         _hpTxt.text = LanguageMgr.GetTranslation("MaxHp");
         PositionUtils.setPos(_hpTxt,"petsBag.evolution.hpPos");
         _hpAddedTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.propValueTxt");
         addChild(_hpAddedTxt);
         _hpAddedTxt.x = _hpTxt.x + 55;
         _hpAddedTxt.y = _hpTxt.y;
         _hpAddedTxt.text = "0";
         _txt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.Txt");
         addChild(_txt);
         _txt.text = LanguageMgr.GetTranslation("ddt.pets.evolution.helpTxt");
         if(_self.evolutionGrade >= PetsAdvancedManager.Instance.evolutionDataList.length)
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
         var _loc2_:* = null;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = PetsAdvancedManager.Instance.evolutionDataList;
         for each(var _loc9_ in PetsAdvancedManager.Instance.evolutionDataList)
         {
            if(_self.evolutionGrade == 0)
            {
               _currentGradeInfo = new PetFightPropertyData();
            }
            if(_loc9_.ID == _self.evolutionGrade)
            {
               _currentGradeInfo = _loc9_;
            }
            else if(_loc9_.ID == _self.evolutionGrade + 1)
            {
               _nextGradeInfo = _loc9_;
            }
         }
         var _loc6_:int = !!_petInfo.IsEquip?_petInfo.Blood + _currentGradeInfo.Blood:_petInfo.Blood;
         var _loc5_:int = !!_petInfo.IsEquip?_petInfo.Attack + _currentGradeInfo.Attack:_petInfo.Attack;
         var _loc3_:int = !!_petInfo.IsEquip?_petInfo.Defence + _currentGradeInfo.Defence:_petInfo.Defence;
         var _loc8_:int = !!_petInfo.IsEquip?_petInfo.Agility + _currentGradeInfo.Agility:_petInfo.Agility;
         var _loc4_:int = !!_petInfo.IsEquip?_petInfo.Luck + _currentGradeInfo.Lucky:_petInfo.Luck;
         var _loc1_:Array = [_loc6_,_loc5_,_loc3_,_loc8_,_loc4_];
         if(_self.evolutionGrade >= PetsAdvancedManager.Instance.evolutionDataList.length)
         {
            _tip.tipData = "0/0";
            _progress.maxAdvancedGrade();
            _loc2_ = [0,0,0,0,0];
         }
         else if(_nextGradeInfo)
         {
            _progress.max = _nextGradeInfo.Exp - _currentGradeInfo.Exp;
            _progress.setProgress(_self.evolutionExp - _currentGradeInfo.Exp);
            _loc2_ = [_nextGradeInfo.Blood - _currentGradeInfo.Blood,_nextGradeInfo.Attack - _currentGradeInfo.Attack,_nextGradeInfo.Defence - _currentGradeInfo.Defence,_nextGradeInfo.Agility - _currentGradeInfo.Agility,_nextGradeInfo.Lucky - _currentGradeInfo.Lucky];
         }
         _loc7_ = 0;
         while(_loc7_ < _itemVector.length)
         {
            _itemVector[_loc7_].setData(_loc7_,_loc1_[_loc7_],_loc2_[_loc7_]);
            _loc7_++;
         }
         setAddedTxt();
      }
      
      private function setAddedTxt() : void
      {
         _attackAddedTxt.text = "" + _currentGradeInfo.Attack;
         _defenceAddedTxt.text = "" + _currentGradeInfo.Defence;
         _agilityAddedTxt.text = "" + _currentGradeInfo.Agility;
         _luckAddedTxt.text = "" + _currentGradeInfo.Lucky;
         _hpAddedTxt.text = "" + _currentGradeInfo.Blood;
      }
      
      override protected function __enterFrame(param1:Event) : void
      {
         if(!_gradeMc)
         {
            return;
         }
         if(_gradeMc.currentFrame >= 19)
         {
            _gradeMc.stop();
            removeChild(_gradeMc);
            _gradeMc = null;
            removeEventListener("enterFrame",__enterFrame);
            updateData();
            _evolutionGradeTxt.text = "LV." + _self.evolutionGrade;
            _petsBasicInfoView.dispatchEvent(new PetsAdvancedEvent("starOrGrade_movie_complete"));
            playNumMovie();
         }
      }
      
      override protected function addEvent() : void
      {
         super.addEvent();
         SocketManager.Instance.addEventListener(PkgEvent.format(68,23),__evolutionHandler);
      }
      
      protected function __evolutionHandler(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         if(_loc3_)
         {
            _btn.enable = false;
            PetsAdvancedControl.Instance.dispatchEvent(new PetsAdvancedEvent("advanced_complete"));
         }
         _bagCell.updateCount();
         _progress.setProgress(_self.evolutionExp - _currentGradeInfo.Exp,_loc3_);
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,23),__evolutionHandler);
      }
      
      override public function dispose() : void
      {
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         super.dispose();
      }
   }
}
