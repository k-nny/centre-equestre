import React, { useState } from 'react';
import { supabase, APP_KEY } from '../supabaseClient';

export default function FormCheval({ fetchData }) {
  const [nom, setNom] = useState('');
  const [heures, setHeures] = useState(0);

  const handleSubmit = async (e) => {
    e.preventDefault();
    await supabase.from('equides').insert([{ nom, heures_semaine: heures, app_key: APP_KEY }]);
    setNom(''); setHeures(0);
    fetchData();
  }

  return (
    <form onSubmit={handleSubmit}>
      <h3>Ajouter Cheval</h3>
      <input type="text" value={nom} onChange={e=>setNom(e.target.value)} placeholder="Nom"/>
      <input type="number" value={heures} onChange={e=>setHeures(e.target.value)} placeholder="Heures"/>
      <button type="submit">Ajouter</button>
    </form>
  )
}