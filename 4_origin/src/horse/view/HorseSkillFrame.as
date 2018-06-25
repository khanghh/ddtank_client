package horse.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import horse.HorseManager;
   import road7th.data.DictionaryData;
   import room.view.RoomPropCell;
   
   public class HorseSkillFrame extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _upCellsContainer:HBox;
      
      private var _upCells:Vector.<RoomPropCell>;
      
      private var _skillUpView:HorseSkillUpFrame;
      
      public function HorseSkillFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         var j:int = 0;
         var cell2:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.horse.skillFrame.bg");
         addChild(_bg);
         var sprite:Sprite = new Sprite();
         var tmpData:Array = HorseManager.instance.horseSkillGetArray;
         var tmpLen:int = tmpData.length;
         for(i = 0; i < tmpLen; )
         {
            cell = new HorseSkillFrameCell(tmpData[i]);
            cell.x = i % 4 * 70;
            cell.y = int(i / 4) * 96;
            sprite.addChild(cell);
            i++;
         }
         var scrollPanel:ScrollPanel = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.skillCellList");
         scrollPanel.setView(sprite);
         addChild(scrollPanel);
         _upCellsContainer = ComponentFactory.Instance.creatComponentByStylename("horse.skillFrame.upCellsContainer");
         addChild(_upCellsContainer);
         _upCells = new Vector.<RoomPropCell>();
         for(j = 0; j < 3; )
         {
            cell2 = new RoomPropCell(true,j,true);
            _upCellsContainer.addChild(cell2);
            _upCells.push(cell2);
            j++;
         }
         updateSkillStatus(null);
         _skillUpView = new HorseSkillUpFrame();
         _skillUpView.x = 386;
         _skillUpView.y = 87;
         addChild(_skillUpView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         HorseManager.instance.addEventListener("horseTakeUpDownSkill",updateSkillStatus);
      }
      
      private function updateSkillStatus(event:Event) : void
      {
         var i:int = 0;
         var tmpKey:* = null;
         var tmpUseSkillList:DictionaryData = HorseManager.instance.curUseSkillList;
         var tmplen:int = _upCells.length;
         for(i = 0; i < tmplen; )
         {
            tmpKey = (i + 1).toString();
            if(tmpUseSkillList.hasKey(tmpKey))
            {
               _upCells[i].skillId = tmpUseSkillList[tmpKey];
            }
            else
            {
               _upCells[i].skillId = 0;
            }
            i++;
         }
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
      
      public function dispose() : void
      {
         var cell:* = null;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_upCellsContainer);
         _upCellsContainer = null;
         while(_upCells.length)
         {
            cell = _upCells.shift();
            ObjectUtils.disposeObject(cell);
            cell = null;
         }
         ObjectUtils.disposeObject(_upCells);
         _upCells = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
