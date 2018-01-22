package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import tofflist.TofflistEvent;
   import tofflist.TofflistModel;
   
   public class TofflistThirdClassMenu extends HBox implements Disposeable
   {
      
      public static const PERSON_LOCAL_BATTLE:String = "personLocalBattle";
      
      public static const PERSON_LOCAL_LEVEL:String = "personLocalLevel";
      
      public static const PERSON_LOCAL_ACHIVE:String = "personLocalAchive";
      
      public static const PERSON_LOCAL_CHARM:String = "personLocalCharm";
      
      public static const PERSON_LOCAL_MATCH:String = "personLocalMatch";
      
      public static const PERSON_LOCAL_MOUNTS:String = "personLocalMounts";
      
      public static const PERSON_CROSS_BATTLE:String = "personCrossBattle";
      
      public static const PERSON_CROSS_LEVEL:String = "personCrossLevel";
      
      public static const PERSON_CROSS_ACHIVE:String = "personCrossAchive";
      
      public static const PERSON_CROSS_CHARM:String = "personCrossCharm";
      
      public static const PERSON_CROSS_MOUNTS:String = "personCrossMounts";
      
      public static const CONSORTIA_LOCAL_BATTLE:String = "consortiaLocalBattle";
      
      public static const CONSORTIA_LOCAL_LEVEL:String = "consortiaLocalLevel";
      
      public static const CONSORTIA_LOCAL_ASSET:String = "consortiaLocalAsset";
      
      public static const CONSORTIA_LOCAL_CHARM:String = "consortiaLocalCharm";
      
      public static const CONSORTIA_CROSS_BATTLE:String = "consortiaCrossBattle";
      
      public static const CONSORTIA_CROSS_LEVEL:String = "consortiaCrossLevel";
      
      public static const CONSORTIA_CROSS_ASSET:String = "consortiaCrossAsset";
      
      public static const CONSORTIA_CROSS_CHARM:String = "consortiaCrossCharm";
      
      public static const TEAM_CROSS:String = "teamCross";
      
      public static const TEAM_THE:String = "teamThe";
      
      public static const DAY:String = "day";
      
      public static const TOTAL:String = "total";
      
      public static const WEEK:String = "week";
      
      private static const BTN_CONST:Array = ["day","week","total"];
       
      
      private var _dayBtn:SelectedTextButton;
      
      private var _weekBtn:SelectedTextButton;
      
      private var _totalBtn:SelectedTextButton;
      
      private var _btns:Array;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      public function TofflistThirdClassMenu()
      {
         super();
         _btns = [];
         initView();
      }
      
      private function initView() : void
      {
         _dayBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.dayAddBtn");
         _weekBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.weekAddBtn");
         _totalBtn = ComponentFactory.Instance.creatComponentByStylename("toffilist.accumulateBtn");
         _dayBtn.text = LanguageMgr.GetTranslation("tofflist.dayAdd");
         _weekBtn.text = LanguageMgr.GetTranslation("tofflist.weekAdd");
         _totalBtn.text = LanguageMgr.GetTranslation("tofflist.total");
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_dayBtn);
         _selectedButtonGroup.addSelectItem(_weekBtn);
         _selectedButtonGroup.addSelectItem(_totalBtn);
         _selectedButtonGroup.selectIndex = 1;
         _btns.push(_dayBtn);
         _btns.push(_weekBtn);
         _btns.push(_totalBtn);
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var _loc1_ in _btns)
         {
            _loc1_.addEventListener("click",__selectToolBarHandler);
            addChild(_loc1_);
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _btns;
         for each(var _loc1_ in _btns)
         {
            _loc1_.removeEventListener("click",__selectToolBarHandler);
            _loc1_.dispose();
         }
         _btns = null;
      }
      
      public function selectType(param1:String, param2:String) : void
      {
         var _loc3_:* = TofflistModel.firstMenuType;
         if("personal" !== _loc3_)
         {
            if("crossServerPersonal" !== _loc3_)
            {
               if("consortia" !== _loc3_)
               {
                  if("crossServerConsortia" !== _loc3_)
                  {
                     if("teams" !== _loc3_)
                     {
                        if("crossServerTeams" !== _loc3_)
                        {
                        }
                     }
                     _loc3_ = false;
                     _btns[1].enable = _loc3_;
                     _btns[0].enable = _loc3_;
                     _btns[2].enable = true;
                     _selectedButtonGroup.selectIndex = 2;
                     type = "total";
                  }
               }
               _loc3_ = TofflistModel.secondMenuType;
               if("battle" !== _loc3_)
               {
                  if("level" !== _loc3_)
                  {
                     _loc3_ = true;
                     _btns[2].enable = _loc3_;
                     _loc3_ = _loc3_;
                     _btns[1].enable = _loc3_;
                     _btns[0].enable = _loc3_;
                     _selectedButtonGroup.selectIndex = 1;
                     type = "week";
                  }
                  addr143:
               }
               _loc3_ = false;
               _btns[1].enable = _loc3_;
               _btns[0].enable = _loc3_;
               _btns[2].enable = true;
               _selectedButtonGroup.selectIndex = 2;
               type = "total";
               §§goto(addr143);
            }
            addr189:
            return;
         }
         _loc3_ = TofflistModel.secondMenuType;
         if("battle" !== _loc3_)
         {
            if("mounts" !== _loc3_)
            {
               _loc3_ = true;
               _btns[2].enable = _loc3_;
               _loc3_ = _loc3_;
               _btns[1].enable = _loc3_;
               _btns[0].enable = _loc3_;
               _selectedButtonGroup.selectIndex = 1;
               type = "week";
            }
            addr74:
            §§goto(addr189);
         }
         _loc3_ = false;
         _btns[1].enable = _loc3_;
         _btns[0].enable = _loc3_;
         _btns[2].enable = true;
         _selectedButtonGroup.selectIndex = 2;
         type = "total";
         §§goto(addr74);
      }
      
      public function get type() : String
      {
         return TofflistModel.thirdMenuType;
      }
      
      public function set type(param1:String) : void
      {
         TofflistModel.thirdMenuType = param1;
         dispatchEvent(new TofflistEvent("tofflisttoolbarselect",type));
      }
      
      private function __selectToolBarHandler(param1:MouseEvent) : void
      {
         if(type == param1.currentTarget.name)
         {
            return;
         }
         SoundManager.instance.play("008");
         type = BTN_CONST[_btns.indexOf(param1.currentTarget)];
      }
   }
}
