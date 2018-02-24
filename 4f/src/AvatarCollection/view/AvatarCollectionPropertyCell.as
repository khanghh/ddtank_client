package AvatarCollection.view
{
   import AvatarCollection.data.AvatarCollectionUnitVo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class AvatarCollectionPropertyCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _index:int;
      
      public function AvatarCollectionPropertyCell(param1:int){super();}
      
      public function refreshView(param1:AvatarCollectionUnitVo, param2:int) : void{}
      
      public function refreshAllProperty(param1:AvatarCollectionUnitVo) : void{}
      
      public function dispose() : void{}
   }
}
