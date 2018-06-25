package bombKing.components
{
   import bombKing.data.BKingPlayerInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class BKingPlayerItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _playerName:FilterFrameText;
      
      private var _info:BKingPlayerInfo;
      
      private var _place:int;
      
      private var _curStatus:int;
      
      private var _pos:Point;
      
      public function BKingPlayerItem(place:int)
      {
         super();
         _place = place;
         initView();
      }
      
      private function initView() : void
      {
         if(_place < 16)
         {
            if(_place < 8)
            {
               if(_place < 4)
               {
                  _bg = ClassUtils.CreatInstance("bombKing.top2Bg");
                  _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item2Txt");
               }
               else
               {
                  _bg = ClassUtils.CreatInstance("bombKing.top4Bg");
                  _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item4Txt");
               }
            }
            else
            {
               _bg = ClassUtils.CreatInstance("bombKing.top8Bg");
               _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item8Txt");
            }
         }
         else
         {
            _bg = ClassUtils.CreatInstance("bombKing.top16Bg");
            _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item16Txt");
         }
         _bg.gotoAndStop(1);
         _pos = new Point(_playerName.x,_playerName.y);
         addChild(_bg);
         addChild(_playerName);
      }
      
      public function set info(info:BKingPlayerInfo) : void
      {
         _info = info;
         if(_info)
         {
            if(_info.status != _curStatus)
            {
               _curStatus = _info.status;
               switch(int(_curStatus) - -1)
               {
                  case 0:
                     _bg.gotoAndStop(3);
                     break;
                  case 1:
                     _bg.gotoAndStop(1);
                     break;
                  case 2:
                     _bg.gotoAndStop(2);
               }
               setNameTxtStyle();
            }
            _playerName.text = _info.name;
         }
         else
         {
            _bg.gotoAndStop(1);
            _playerName.text = "";
         }
      }
      
      public function get info() : BKingPlayerInfo
      {
         return _info;
      }
      
      private function setNameTxtStyle() : void
      {
         ObjectUtils.disposeObject(_playerName);
         _playerName = null;
         switch(int(_curStatus) - -1)
         {
            case 0:
               _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.itemDarkTxt");
               _playerName.x = _pos.x;
               _playerName.y = _pos.y;
               break;
            case 1:
               if(_place < 16)
               {
                  if(_place < 8)
                  {
                     if(_place < 4)
                     {
                        _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item2Txt");
                     }
                     else
                     {
                        _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item4Txt");
                     }
                  }
                  else
                  {
                     _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item8Txt");
                  }
               }
               else
               {
                  _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.item16Txt");
               }
               break;
            case 2:
               _playerName = ComponentFactory.Instance.creatComponentByStylename("bombKing.itemLightTxt");
               _playerName.x = _pos.x;
               _playerName.y = _pos.y;
         }
         addChild(_playerName);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_playerName);
         _playerName = null;
      }
   }
}
