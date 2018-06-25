package horse
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import horse.data.HorsePicCherishVo;
   import horse.horsePicCherish.HorsePicCherishTip;
   import horse.view.HorseFrame;
   import horse.view.HorseGetSkillView;
   import horse.view.HorseSkillCellTip;
   
   public class HorseControl extends EventDispatcher
   {
      
      private static var _instance:HorseControl;
       
      
      private var _horseFrame:HorseFrame;
      
      public function HorseControl(target:IEventDispatcher = null)
      {
         super(target);
         HorseSkillCellTip;
      }
      
      public static function get instance() : HorseControl
      {
         if(_instance == null)
         {
            _instance = new HorseControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         HorseManager.instance.addEventListener("horseOpenView",__onOpenView);
         HorseManager.instance.addEventListener("horseHideView",__onHideView);
      }
      
      protected function __onHideView(event:Event) : void
      {
         closeFrame();
      }
      
      protected function __onOpenView(event:Event) : void
      {
         var currentIndex:int = 0;
         var horsePicCherishList:* = undefined;
         var index:int = 0;
         if(!_horseFrame)
         {
            _horseFrame = ComponentFactory.Instance.creatComponentByStylename("HorseFrame");
            _horseFrame.addEventListener("dispose",frameDisposeHandler,false,0,true);
            LayerManager.Instance.addToLayer(_horseFrame,3,true,1);
            if(HorseManager.instance.isSkipFromBagView)
            {
               currentIndex = 1;
               horsePicCherishList = HorseManager.instance.getHorsePicCherishData();
               for(index = 0; index < horsePicCherishList.length; )
               {
                  if(horsePicCherishList[index].ID == HorseManager.instance.skipHorsePicCherishId)
                  {
                     if(index != 0)
                     {
                        currentIndex = int(index / 10) + 1;
                     }
                     break;
                  }
                  index++;
               }
               _horseFrame.setImagePage(currentIndex);
            }
         }
      }
      
      private function frameDisposeHandler(event:ComponentEvent) : void
      {
         if(_horseFrame)
         {
            _horseFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         _horseFrame = null;
      }
      
      public function closeFrame() : void
      {
         if(_horseFrame)
         {
            _horseFrame.removeEventListener("dispose",frameDisposeHandler);
         }
         ObjectUtils.disposeObject(_horseFrame);
         _horseFrame = null;
      }
      
      public function upFloatCartoonPlayComplete() : void
      {
         HorseManager.instance.isUpFloatCartoonComplete = true;
         HorseManager.instance.dispatchEvent(new Event("horseUpHorseStep2"));
      }
      
      private function openGetNewSkillView() : void
      {
         var getSkillView:HorseGetSkillView = new HorseGetSkillView();
         getSkillView.show(HorseManager.instance.curHasSkillList[HorseManager.instance.curHasSkillList.length - 1].skillId);
         HorseManager.instance.isNeedPlayGetNewSkillCartoon = false;
         HorseManager.instance.isUpFloatCartoonComplete = false;
      }
      
      private function updateHorse() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = PlayerManager.Instance.Self.horsePicCherishDic;
         for(var key in PlayerManager.Instance.Self.horsePicCherishDic)
         {
            PlayerManager.Instance.Self.horsePicCherishDic[key].isUsed = int(key) == HorseManager.instance.curUseHorse;
         }
      }
      
      public function getHorsePicCherishState(id:int, templateId:int) : Array
      {
         var isPicCherishActive:Boolean = false;
         var isHasPicCherish:* = false;
         var isPicCherishUsed:Boolean = false;
         isPicCherishActive = PlayerManager.Instance.Self.horsePicCherishDic.hasKey(id);
         isHasPicCherish = PlayerManager.Instance.Self.getBag(1).getItemByTemplateId(templateId) != null;
         if(isPicCherishActive)
         {
            isPicCherishUsed = PlayerManager.Instance.Self.horsePicCherishDic[id].isUsed;
         }
         return [isPicCherishActive,isHasPicCherish,isPicCherishUsed];
      }
      
      public function getHorsePicCherishAddProperty(id:int) : Array
      {
         var _loc4_:int = 0;
         var _loc3_:* = HorseManager.instance.getHorsePicCherishData();
         for each(var data in HorseManager.instance.getHorsePicCherishData())
         {
            if(data.ID == id)
            {
               return [data.AddHurt,data.AddGuard,data.AddBlood,data.MagicAttack,data.MagicDefence];
            }
         }
         return [0,0,0,0,0];
      }
   }
}
