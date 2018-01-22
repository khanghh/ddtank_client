package nationDay
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import nationDay.model.NationModel;
   import road7th.comm.PackageIn;
   
   public class NationDayManager extends CoreManager
   {
      
      public static const LETTERS_NATIONAL_DAY:String = "lt_nation_day";
      
      public static const LETTERS_DDT_KING:String = "lt_ddt_king";
      
      public static const NATION_OPENVIEW:String = "nationOpenView";
      
      public static var WordInfo:Array = [[1,2,3,4],[5,6,7,8],[9,5,10,11],[12,2,13,14]];
      
      public static var WordRes:Array = [["1","2","3","4"],["5","6","7","8"],["9","10","11","12"],["13","14","15","16"]];
      
      private static var _instance:NationDayManager;
       
      
      private var _nationModel:NationModel;
      
      private var _openFlag:Boolean;
      
      private var _nationDayIcon:MovieImage;
      
      private var _hallView:HallStateView;
      
      public function NationDayManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : NationDayManager
      {
         if(!_instance)
         {
            _instance = new NationDayManager();
         }
         return _instance;
      }
      
      public function get curActivity() : String
      {
         return "lt_nation_day";
      }
      
      public function setup() : void
      {
         if(NationDayManager.instance.curActivity != "lt_nation_day")
         {
            return;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(288,1),__onGetHideTitleFlag);
      }
      
      override protected function start() : void
      {
         dispatchEvent(new Event("nationOpenView"));
      }
      
      protected function __onGetHideTitleFlag(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _openFlag = _loc2_.readBoolean();
         if(_openFlag)
         {
            showNationIcon();
         }
         else
         {
            deleteNaitonBtn();
         }
      }
      
      private function showNationIcon() : void
      {
         if(_hallView)
         {
            createNationBtn();
         }
      }
      
      private function createNationBtn() : void
      {
         if(!_nationDayIcon)
         {
            _nationDayIcon = ComponentFactory.Instance.creatComponentByStylename("hall.nationDayBtn");
            _nationDayIcon.buttonMode = true;
            _nationDayIcon.addEventListener("click",__onNationDayClick);
         }
         setIconFrame();
      }
      
      public function setIconFrame() : void
      {
         var _loc1_:int = 0;
         _nationDayIcon.setFrame(1);
         _loc1_ = 0;
         while(_loc1_ < WordInfo.length)
         {
            if(_nationModel && getExchangeNum(_loc1_) > 0)
            {
               _nationDayIcon.setFrame(2);
               break;
            }
            _loc1_++;
         }
      }
      
      private function getExchangeNum(param1:int) : int
      {
         var _loc2_:int = 65535;
         var _loc5_:int = 0;
         var _loc4_:* = WordInfo[param1];
         for(var _loc3_ in WordInfo[param1])
         {
            _loc2_ = Math.min(_loc2_,_nationModel.WordArray[WordInfo[param1][_loc3_]]);
         }
         return _loc2_;
      }
      
      protected function __onNationDayClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      public function addNationBtn(param1:HallStateView) : void
      {
         _hallView = param1;
         if(_openFlag)
         {
            createNationBtn();
         }
      }
      
      public function deleteNaitonBtn() : void
      {
         if(_nationDayIcon)
         {
            _nationDayIcon.addEventListener("click",__onNationDayClick);
            _nationDayIcon.dispose();
            _nationDayIcon = null;
         }
      }
      
      public function get nationDayIcon() : MovieImage
      {
         return _nationDayIcon;
      }
      
      public function get nationModel() : NationModel
      {
         return _nationModel;
      }
      
      public function set nationModel(param1:NationModel) : void
      {
         _nationModel = param1;
      }
   }
}
