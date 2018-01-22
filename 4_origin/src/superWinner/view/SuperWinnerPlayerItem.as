package superWinner.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import vip.VipController;
   
   public class SuperWinnerPlayerItem extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _info:PlayerInfo;
      
      private var _levelIcon:LevelIcon;
      
      private var _sexIcon:SexIcon;
      
      private var _name:FilterFrameText;
      
      private var _vipName:GradientText;
      
      public function SuperWinnerPlayerItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _name = ComponentFactory.Instance.creat("asset.superWinner.playerlist.name");
         addChild(_name);
         _levelIcon = new LevelIcon();
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = ComponentFactory.Instance.creatCustomObject("asset.superWinner.PlayerItem.SexIcon");
         addChild(_sexIcon);
      }
      
      public function dispose() : void
      {
         _name = null;
         _levelIcon = null;
         _sexIcon = null;
         _vipName = null;
         ObjectUtils.removeChildAllChildren(this);
      }
      
      public function get sexIcon() : SexIcon
      {
         return _sexIcon;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setCellValue(param1:*) : void
      {
         _info = param1;
         update();
      }
      
      private function update() : void
      {
         ObjectUtils.disposeObject(_vipName);
         if(_info.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(120,_info.typeVIP);
            _vipName.x = _name.x;
            _vipName.y = _name.y;
            _vipName.text = _info.NickName;
            addChild(_vipName);
         }
         _name.text = _info.NickName;
         PositionUtils.adaptNameStyle(_info,_name,_vipName);
         _sexIcon.setSex(_info.Sex);
         _levelIcon.setInfo(_info.Grade,0,0,0,0,0,0,false);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
