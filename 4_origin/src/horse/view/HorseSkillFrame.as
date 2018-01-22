package horse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.HBox;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import horse.HorseManager;
   import road7th.data.DictionaryData;
   import room.view.RoomPropCell;
   import trainer.view.NewHandContainer;
   
   public class HorseSkillFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _upCellsContainer:HBox;
      
      private var _upCells:Vector.<RoomPropCell>;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function HorseSkillFrame()
      {
         super();
         initView();
         initEvent();
         guideHandler();
      }
      
      private function guideHandler() : void
      {
         if(!PlayerManager.Instance.Self.isNewOnceFinish(114) && HorseManager.instance.curLevel >= 1)
         {
            NewHandContainer.Instance.showArrow(128,0,new Point(55,-32),"asset.horse.skillEquipGuideTxt","horse.skillFrame.equipGuidePos",_container);
         }
      }
      
      private function initView() : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         titleText = LanguageMgr.GetTranslation("horse.skillFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.skillFrame.bg");
         addToContent(_bg);
         var _loc5_:Sprite = new Sprite();
         var _loc1_:Array = HorseManager.instance.horseSkillGetArray;
         var _loc3_:int = _loc1_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc4_ = new HorseSkillFrameCell(_loc1_[_loc8_]);
            _loc4_.x = _loc8_ % 4 * 67;
            _loc4_.y = int(_loc8_ / 4) * 81;
            _loc5_.addChild(_loc4_);
            _loc8_++;
         }
         var _loc7_:ScrollPanel = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.skillCellList");
         _loc7_.setView(_loc5_);
         addToContent(_loc7_);
         _upCellsContainer = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.upCellsContainer");
         addToContent(_upCellsContainer);
         _upCells = new Vector.<RoomPropCell>();
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            _loc2_ = new RoomPropCell(true,_loc6_,true);
            _upCellsContainer.addChild(_loc2_);
            _upCells.push(_loc2_);
            _loc6_++;
         }
         updateSkillStatus(null);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"horse.skillFrame.helpBtn",null,LanguageMgr.GetTranslation("store.view.HelpButtonText"),"asset.horse.skillFrame.helpPromptTxt",404,484) as SimpleBitmapButton;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         HorseManager.instance.addEventListener("horseTakeUpDownSkill",updateSkillStatus);
      }
      
      private function updateSkillStatus(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc4_:DictionaryData = HorseManager.instance.curUseSkillList;
         var _loc3_:int = _upCells.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = (_loc5_ + 1).toString();
            if(_loc4_.hasKey(_loc2_))
            {
               _upCells[_loc5_].skillId = _loc4_[_loc2_];
            }
            else
            {
               _upCells[_loc5_].skillId = 0;
            }
            _loc5_++;
         }
         if(!PlayerManager.Instance.Self.isNewOnceFinish(115))
         {
            NewHandContainer.Instance.showArrow(128,0,new Point(339,-45),"","",this);
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         HorseManager.instance.removeEventListener("horseTakeUpDownSkill",updateSkillStatus);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _bg = null;
         _upCellsContainer = null;
         _upCells = null;
         _helpBtn = null;
         if(!PlayerManager.Instance.Self.isNewOnceFinish(115) && PlayerManager.Instance.Self.isNewOnceFinish(114))
         {
            SocketManager.Instance.out.syncWeakStep(115);
            NewHandContainer.Instance.clearArrowByID(128);
            HorseManager.instance.dispatchEvent(new Event("horseGuide6To7"));
         }
      }
   }
}
