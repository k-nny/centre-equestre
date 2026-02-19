import React from 'react';

export default function Planning({ equides, cavaliers, moniteurs, cours, affectations }) {
  return (
    <div>
      {cours.map(c => (
        <div key={c.id} style={{border:'1px solid #ccc', margin:'10px', padding:'5px'}}>
          <strong>{c.date} - {c.heure} - {c.type_cours}</strong>
          <ul>
            {(affectations||[]).filter(a=>a.cours_instance_id===c.id).map(a=>{
              const cavalier = cavaliers.find(cav=>cav.id===a.cavalier_id);
              const cheval = equides.find(eq=>eq.id===a.equide_id);
              const moniteur = moniteurs.find(m=>m.id===a.moniteur_id);
              return <li key={a.id}>{cavalier?.prenom||"?"} → {cheval?.nom||"?"} ({moniteur?.prenom||"?"})</li>
            })}
          </ul>
        </div>
      ))}
    </div>
  )
}