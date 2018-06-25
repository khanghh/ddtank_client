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
      
      public function NationDayManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      protected function __onGetHideTitleFlag(event:PkgEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         _openFlag = pkg.readBoolean();
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
         var j:int = 0;
         _nationDayIcon.setFrame(1);
         for(j = 0; j < WordInfo.length; j++)
         {
            if(_nationModel && getExchangeNum(j) > 0)
            {
               _nationDayIcon.setFrame(2);
               break;
            }
         }
      }
      
      private function getExchangeNum(index:int) : int
      {
         var num:int = 65535;
         var _loc5_:int = 0;
         var _loc4_:* = WordInfo[index];
         for(var i in WordInfo[index])
         {
            num = Math.min(num,_nationModel.WordArray[WordInfo[index][i]]);
         }
         return num;
      }
      
      protected function __onNationDayClick(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         show();
      }
      
      public function addNationBtn(hall:HallStateView) : void
      {
         _hallView = hall;
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
      
      public function set nationModel(value:NationModel) : void
      {
         _nationModel = value;
      }
   }
}
