package ddtKingWay.view
{
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.bagStore.BagStore;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddtKingWay.DDTKingWayManager;
   import farm.FarmModelController;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import hall.tasktrack.HallTaskTrackManager;
   import horse.HorseManager;
   import petsBag.PetsBagManager;
   import quest.TaskManager;
   
   public class DDTKingWayLevelTargetItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _taskTargetText:FilterFrameText;
      
      private var _stateImage:ScaleFrameImage;
      
      private var _jumpBtn:BaseButton;
      
      private var _num:int;
      
      private var _taskStatus:Boolean;
      
      private var _info:QuestInfo;
      
      public function DDTKingWayLevelTargetItem(param1:int = 0){super();}
      
      public function updataStutas(param1:QuestInfo, param2:Boolean, param3:Boolean) : void{}
      
      private function creatStateText(param1:Boolean) : void{}
      
      private function textClickHandler(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
