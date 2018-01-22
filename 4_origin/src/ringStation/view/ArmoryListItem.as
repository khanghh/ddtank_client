package ringStation.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import labyrinth.data.RankingInfo;
   
   public class ArmoryListItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _itemBG:ScaleFrameImage;
      
      private var _ranking:FilterFrameText;
      
      private var _name:FilterFrameText;
      
      private var _fighting:FilterFrameText;
      
      private var _levelIcon:LevelIcon;
      
      private var _info:RankingInfo;
      
      public function ArmoryListItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.List.itemBG");
         addChild(_itemBG);
         _ranking = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.List.text1");
         addChild(_ranking);
         _name = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.List.text2");
         addChild(_name);
         _fighting = ComponentFactory.Instance.creatComponentByStylename("ringStation.view.armory.List.text3");
         addChild(_fighting);
         _levelIcon = new LevelIcon();
         PositionUtils.setPos(_levelIcon,"ringStation.view.armory.listItem.levelPos");
         addChild(_levelIcon);
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         _ranking.text = (param3 + 1).toString();
         if(param3 % 2 != 0)
         {
            _itemBG.setFrame(2);
         }
         else
         {
            _itemBG.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         return _info;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1 as RankingInfo;
         _name.text = _info.PlayerName.toString();
         _levelIcon.setInfo(_info.FamLevel,0,0,0,0,0,0,false,false);
         _fighting.text = _info.Fighting.toString();
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         if(_itemBG)
         {
            ObjectUtils.disposeObject(_itemBG);
         }
         _itemBG = null;
         if(_ranking)
         {
            ObjectUtils.disposeObject(_ranking);
         }
         _ranking = null;
         if(_name)
         {
            ObjectUtils.disposeObject(_name);
         }
         _name = null;
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
         }
         _levelIcon = null;
         if(_fighting)
         {
            ObjectUtils.disposeObject(_fighting);
         }
         _fighting = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
