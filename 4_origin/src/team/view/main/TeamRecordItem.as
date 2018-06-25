package team.view.main
{
   import ddt.manager.LanguageMgr;
   import road7th.utils.DateUtils;
   import team.model.TeamRecordInfo;
   import team.view.mornui.item.TeamRecordItemUI;
   
   public class TeamRecordItem extends TeamRecordItemUI
   {
       
      
      private var _info:TeamRecordInfo;
      
      public function TeamRecordItem()
      {
         super();
      }
      
      public function set info(value:TeamRecordInfo) : void
      {
         _info = value;
         if(_info)
         {
            clip_icon.index = !!_info.isWin?0:1;
            label_name.text = _info.enemyName;
            label_date.text = DateUtils.dateFormat6(_info.date);
            label_score.text = LanguageMgr.GetTranslation("team.record.activeTip",_info.active);
            clip_icon.visible = true;
            img_vs.visible = true;
            buttonMode = true;
            mouseChildren = true;
            mouseEnabled = true;
         }
         else
         {
            clip_icon.visible = false;
            img_vs.visible = false;
            label_name.text = "";
            label_date.text = "";
            label_score.text = "";
            buttonMode = false;
            mouseChildren = false;
            mouseEnabled = false;
         }
      }
      
      public function get info() : TeamRecordInfo
      {
         return _info;
      }
   }
}
