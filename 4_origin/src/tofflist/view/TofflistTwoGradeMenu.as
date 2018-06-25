package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistTwoGradeMenu extends HBox implements Disposeable
   {
      
      public static const ACHIEVEMENTPOINT:String = "achievementpoint";
      
      public static const ASSETS:String = "assets";
      
      public static const BATTLE:String = "battle";
      
      public static const GESTE:String = "geste";
      
      public static const LEVEL:String = "level";
      
      public static const CHARM:String = "charm";
      
      public static const MATCHES:String = "matches";
      
      public static const MOUNTS:String = "mounts";
      
      public static const INTEGRAL:String = "integral";
      
      private static const BTN_CONST:Array = ["battle","level","assets","charm","matches","mounts","integral"];
       
      
      private var _battleBtn:SelectedTextButton;
      
      private var _assetsBtn:SelectedTextButton;
      
      private var _levelBtn:SelectedTextButton;
      
      private var _achiveBtn:SelectedTextButton;
      
      private var _charmBtn:SelectedTextButton;
      
      private var _matcheBtn:SelectedTextButton;
      
      private var _mountsBtn:SelectedTextButton;
      
      private var _integralBtn:SelectedTextButton;
      
      private var _btns:Array;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      public function TofflistTwoGradeMenu()
      {
         super();
         _spacing = -7;
         _btns = [];
         initView();
      }
      
      private function initView() : void
      {
         _battleBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.battleBtn");
         _levelBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.gradeOrderBtn");
         _assetsBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.assetBtn");
         _charmBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.charmvalueBtn");
         _matcheBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.mathesBtn");
         _mountsBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.mountsBtn");
         _integralBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.integralBtn");
         _battleBtn.text = LanguageMgr.GetTranslation("tank.menu.FightPoweTxt");
         _levelBtn.text = LanguageMgr.GetTranslation("tank.menu.LevelTxt");
         _assetsBtn.text = LanguageMgr.GetTranslation("consortia.Money");
         _charmBtn.text = LanguageMgr.GetTranslation("ddt.giftSystem.GiftGoodItem.charmNum");
         _matcheBtn.text = LanguageMgr.GetTranslation("tank.menu.battleGround");
         _mountsBtn.text = LanguageMgr.GetTranslation("tank.menu.mounts");
         _integralBtn.text = LanguageMgr.GetTranslation("team.rank.score");
         _btns.push(_battleBtn);
         _btns.push(_levelBtn);
         _btns.push(_assetsBtn);
         _btns.push(_charmBtn);
         _btns.push(_matcheBtn);
         _btns.push(_mountsBtn);
         _btns.push(_integralBtn);
         addChild(_battleBtn);
         addChild(_levelBtn);
         addChild(_assetsBtn);
         addChild(_charmBtn);
         addChild(_matcheBtn);
         addChild(_mountsBtn);
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_battleBtn);
         _selectedButtonGroup.addSelectItem(_levelBtn);
         _selectedButtonGroup.addSelectItem(_assetsBtn);
         _selectedButtonGroup.addSelectItem(_charmBtn);
         _selectedButtonGroup.addSelectItem(_matcheBtn);
         _selectedButtonGroup.addSelectItem(_mountsBtn);
         _selectedButtonGroup.addSelectItem(_integralBtn);
         _selectedButtonGroup.selectIndex = 0;
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var btn in _btns)
         {
            btn.addEventListener("click",__selectToolBarHandler);
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var btn in _btns)
         {
            btn.dispose();
            btn.removeEventListener("click",__selectToolBarHandler);
         }
         if(_battleBtn)
         {
            ObjectUtils.disposeObject(_battleBtn);
         }
         if(_levelBtn)
         {
            ObjectUtils.disposeObject(_levelBtn);
         }
         if(_assetsBtn)
         {
            ObjectUtils.disposeObject(_assetsBtn);
         }
         if(_charmBtn)
         {
            ObjectUtils.disposeObject(_charmBtn);
         }
         if(_matcheBtn)
         {
            ObjectUtils.disposeObject(_matcheBtn);
         }
         if(_mountsBtn)
         {
            ObjectUtils.disposeObject(_mountsBtn);
         }
         if(_integralBtn)
         {
            ObjectUtils.disposeObject(_integralBtn);
         }
         _battleBtn = null;
         _levelBtn = null;
         _assetsBtn = null;
         _charmBtn = null;
         _matcheBtn = null;
         _mountsBtn = null;
         _integralBtn = null;
         _btns = null;
         super.dispose();
      }
      
      public function setParentType(parentType:String) : void
      {
         if(parentType == "teams" || parentType == "crossServerTeams")
         {
            type = "integral";
         }
         else
         {
            type = "battle";
         }
         var _loc4_:int = 0;
         var _loc3_:* = _btns;
         for each(var btn in _btns)
         {
            if(btn.parent)
            {
               btn.parent.removeChild(btn);
            }
         }
         if(parentType == "personal")
         {
            addChild(_battleBtn);
            addChild(_levelBtn);
            addChild(_charmBtn);
            addChild(_matcheBtn);
            addChild(_mountsBtn);
         }
         else if(parentType == "crossServerPersonal")
         {
            addChild(_battleBtn);
            addChild(_levelBtn);
            addChild(_charmBtn);
            addChild(_mountsBtn);
         }
         else if(parentType == "consortia" || parentType == "crossServerConsortia")
         {
            addChild(_battleBtn);
            addChild(_levelBtn);
            addChild(_assetsBtn);
            addChild(_charmBtn);
         }
         else if(parentType == "teams" || parentType == "crossServerTeams")
         {
            type = "integral";
            addChild(_integralBtn);
         }
         var _loc6_:int = 0;
         var _loc5_:* = _btns;
         for each(btn in _btns)
         {
            btn.selected = false;
         }
         if(parentType == "teams" || parentType == "crossServerTeams")
         {
            _selectedButtonGroup.selectIndex = 6;
         }
         else
         {
            _selectedButtonGroup.selectIndex = 0;
         }
      }
      
      public function get type() : String
      {
         return TofflistModel.secondMenuType;
      }
      
      public function set type(value:String) : void
      {
         TofflistModel.secondMenuType = value;
         dispatchEvent(new TofflistEvent("tofflisttoolbarselect",type));
      }
      
      private function __selectToolBarHandler(event:MouseEvent) : void
      {
         if(type == event.currentTarget.name)
         {
            return;
         }
         SoundManager.instance.play("008");
         type = BTN_CONST[_btns.indexOf(event.currentTarget)];
      }
   }
}
