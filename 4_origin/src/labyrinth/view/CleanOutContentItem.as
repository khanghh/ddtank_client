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
         var _loc1_:int = LabyrinthManager.Instance.model.currentFloor == 0?LabyrinthManager.Instance.model.currentFloor + 1:LabyrinthManager.Instance.model.currentFloor;
         _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueTextII",_loc1_);
         LabyrinthManager.Instance.addEventListener("updateInfo",__updateInfo);
      }
      
      protected function __updateInfo(param1:Event) : void
      {
         updateItem();
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1 as CleanOutInfo;
         updateItem();
      }
      
      private function updateItem() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(!_info)
         {
            _loc1_ = LabyrinthManager.Instance.model.currentFloor == 0?LabyrinthManager.Instance.model.currentFloor + 1:LabyrinthManager.Instance.model.currentFloor;
            _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueTextII",_loc1_);
            _expNum.text = "";
            return;
         }
         _expNum.text = LanguageMgr.GetTranslation("tank.fightLib.FightLibAwardView.exp") + _info.exp.toString();
         _floorNumContent.text = LanguageMgr.GetTranslation("ddt.labyrinth.CleanOutItem.ValueText",_info.FamRaidLevel);
         var _loc2_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _info.TemplateIDs.length)
         {
            _loc2_ = _loc2_ + ("," + ItemManager.Instance.getTemplateById(_info.TemplateIDs[_loc3_]["TemplateID"]).Name);
            if(_info.TemplateIDs[_loc3_]["num"] != 0)
            {
               _loc2_ = _loc2_ + ("x" + _info.TemplateIDs[_loc3_]["num"].toString());
            }
            _loc3_++;
         }
         if(_info.HardCurrency > 0)
         {
            _loc2_ = _loc2_ + LanguageMgr.GetTranslation("dt.labyrinth.CleanOutContentItem.HardCurrency",_info.HardCurrency);
         }
         _expNum.text = _expNum.text + _loc2_;
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
