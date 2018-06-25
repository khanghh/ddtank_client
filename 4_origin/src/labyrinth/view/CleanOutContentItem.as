package labyrinth.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import labyrinth.LabyrinthManager;
   import labyrinth.data.CleanOutInfo;
   
   public class CleanOutContentItem extends Sprite implements IListCell
   {
       
      
      private var _expNum:FilterFrameText;
      
      private var _floorNumContent:FilterFrameText;
      
      private var _info:CleanOutInfo;
      
      public function CleanOutContentItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _expNum = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.CleanOutContentItem.expNum","",this);
         _floorNumContent = UICreatShortcut.creatTextAndAdd("ddt.labyrinth.CleanOutContentItem.floorNumContent","",this);
         var currentFloor:int = LabyrinthManager.Instance.model.currentFloor == 0?LabyrinthManager.Instance.model.currentFloor + 1:LabyrinthManager.Instance.model.currentFloor;
         _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueTextII",currentFloor);
         LabyrinthManager.Instance.addEventListener("updateInfo",__updateInfo);
      }
      
      protected function __updateInfo(event:Event) : void
      {
         updateItem();
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(value:*) : void
      {
         _info = value as CleanOutInfo;
         updateItem();
      }
      
      private function updateItem() : void
      {
         var currentFloor:int = 0;
         var i:int = 0;
         if(!_info)
         {
            currentFloor = LabyrinthManager.Instance.model.currentFloor == 0?LabyrinthManager.Instance.model.currentFloor + 1:LabyrinthManager.Instance.model.currentFloor;
            _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueTextII",currentFloor);
            _expNum.text = "";
            return;
         }
         _expNum.text = LanguageMgr.GetTranslation("tank.fightLib.FightLibAwardView.exp") + _info.exp.toString();
         _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueText",_info.FamRaidLevel);
         var goodsName:String = "";
         for(i = 0; i < _info.TemplateIDs.length; )
         {
            goodsName = goodsName + ("," + ItemManager.Instance.getTemplateById(_info.TemplateIDs[i]["TemplateID"]).Name);
            if(_info.TemplateIDs[i]["num"] != 0)
            {
               goodsName = goodsName + ("x" + _info.TemplateIDs[i]["num"].toString());
            }
            i++;
         }
         if(_info.HardCurrency > 0)
         {
            goodsName = goodsName + LanguageMgr.GetTranslation("dt.labyrinth.CleanOutContentItem.HardCurrency",_info.HardCurrency);
         }
         _expNum.text = _expNum.text + goodsName;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         LabyrinthManager.Instance.removeEventListener("updateInfo",__updateInfo);
         ObjectUtils.disposeObject(_expNum);
         _expNum = null;
         ObjectUtils.disposeObject(_floorNumContent);
         _floorNumContent = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
