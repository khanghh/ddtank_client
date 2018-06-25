package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class Battle extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _battle_txt:FilterFrameText;
      
      public function Battle(battle:int)
      {
         super();
         init();
         BattleNum = battle;
      }
      
      public function get bg() : Bitmap
      {
         return _bg;
      }
      
      public function get battle_txt() : FilterFrameText
      {
         return _battle_txt;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.core.leveltip.BattleBg");
         _battle_txt = ComponentFactory.Instance.creat("core.BattleTxt");
         addChild(_bg);
         addChild(_battle_txt);
      }
      
      public function set BattleNum(battleNum:int) : void
      {
         _battle_txt.text = battleNum.toString();
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_battle_txt)
         {
            ObjectUtils.disposeObject(_battle_txt);
         }
         _battle_txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
